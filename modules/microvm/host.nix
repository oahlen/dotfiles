{
  config,
  lib,
  pkgs,
  vms,
  ...
}:
let
  cfg = config.features.microvm;

  # Connect to a VM by name, resolving its vsock CID from the VM config
  ssh-vm = pkgs.writeShellApplication {
    name = "ssh-vm";
    runtimeInputs = [ pkgs.openssh ];
    text = ''
      if [ $# -lt 1 ]; then
        echo "usage: ssh-vm <vm> [ssh args...]" >&2
        echo "vms: ${lib.concatStringsSep " " cfg.vms}" >&2
        exit 1
      fi

      vm="$1"
      shift

      case "$vm" in
        ${lib.concatMapStrings (name: ''
          ${name}) cid=${toString vms.${name}.config.microvm.vsock.cid} ;;
        '') cfg.vms}
        *)
          echo "ssh-vm: unknown vm '$vm' (known: ${lib.concatStringsSep " " cfg.vms})" >&2
          exit 1
          ;;
      esac

      exec ssh -o ForwardAgent=no -o LogLevel=ERROR "$@" "${config.defaultUser.name}@vsock/$cid"
    '';
  };
in
{
  imports = [ ./network.nix ];

  options.features.microvm.vms = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
    description = "The list of named virtual machines to run on this host.";
  };

  config = {
    assertions =
      let
        registry = import ./registry.nix;
        indices = lib.attrValues registry;
      in
      [
        {
          assertion = lib.length indices == lib.length (lib.unique indices);
          message = "modules/microvm/registry.nix: VM indices must be unique";
        }
        {
          assertion = lib.all (i: i >= 1 && i <= 254) indices;
          message = "modules/microvm/registry.nix: VM indices must be within 1-254";
        }
      ];

    environment.systemPackages = lib.mkIf (cfg.vms != [ ]) [ ssh-vm ];

    microvm = {
      host = {
        enable = cfg.vms != [ ];
        installCommand = false;
      };

      vms = lib.genAttrs cfg.vms (name: {
        evaluatedConfig = vms.${name};
        autostart = false;
      });
    };
  };
}
