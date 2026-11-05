{
  config,
  lib,
  pkgs,
  vms,
  ...
}:
let
  cfg = config.features.microvm;

  # ssh into a VM by name, resolving its vsock CID from the VM config
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
  options.features.microvm.vms = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
    description = "The list of named virtual machines to run on this host.";
  };

  config.environment.systemPackages = lib.mkIf (cfg.vms != [ ]) [ ssh-vm ];

  config.microvm = {
    host = {
      enable = cfg.vms != [ ];
      installCommand = false;
    };

    vms = lib.genAttrs cfg.vms (name: {
      evaluatedConfig = vms.${name};
      autostart = false;
    });
  };
}
