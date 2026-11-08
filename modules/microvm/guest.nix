{
  config,
  lib,
  ...
}:
let
  registry = import ./registry.nix;

  name = config.networking.hostName;
  index =
    registry.${name} or (throw "microvm: '${name}' is missing from modules/microvm/registry.nix");

  hex = lib.fixedWidthString 2 "0" (lib.toLower (lib.toHexString index));
  mac = "02:00:00:00:00:${hex}";
in
{
  imports = [ ./features/persistence.nix ];

  config = {
    microvm = {
      hypervisor = lib.mkDefault "qemu";
      vcpu = lib.mkDefault 4;
      mem = lib.mkDefault (8 * 1024);

      # Host store shared read-only, guest writes go to an overlay
      shares = [
        {
          tag = "ro-store";
          source = "/nix/store";
          mountPoint = "/nix/.ro-store";
          proto = "virtiofs";
          readOnly = true;
        }
      ];

      writableStoreOverlay = "/nix/.rw-store";

      # Routed tap link to the host, see ./network.nix
      interfaces = [
        {
          type = "tap";
          id = "vm${toString index}";
          inherit mac;
        }
      ];

      vsock = {
        ssh.enable = true;
        cid = index + 2; # 0-2 are reserved, so the first VM gets 3
      };
    };

    networking = {
      useNetworkd = true;
      useDHCP = false;
      enableIPv6 = false; # LAN filtering on the host is IPv4 only
    };

    # Static addressing, the host end of the link is always 10.0.0.0
    systemd.network.networks."10-uplink" = {
      matchConfig.MACAddress = mac;
      address = [ "10.0.0.${toString index}/32" ];

      routes = [
        {
          Destination = "10.0.0.0/32";
          GatewayOnLink = true;
        }
        {
          Destination = "0.0.0.0/0";
          Gateway = "10.0.0.0";
          GatewayOnLink = true;
        }
      ];

      networkConfig = {
        # Public resolvers, the LAN router should be off limits
        DNS = [
          "1.1.1.1"
          "1.0.0.1"
        ];

        LinkLocalAddressing = "no";
        IPv6AcceptRA = false;
      };
    };

    defaultUser = {
      name = "oahlen";
      description = "Oscar Ahlén";
    };

    users.users.${config.defaultUser.name} = {
      # No root for the guest user or agents running as it
      extraGroups = lib.mkForce [ ];

      # Public key only; the agent is never forwarded (see `just ssh-vm`)
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBAv3bE2CEsRo/wSyEm3Hk1A7K3i3gTxaT6FffC+tR6r github@ahlen.dev"
      ];
    };

    nix = {
      optimise.automatic = false;
      settings = {
        auto-optimise-store = lib.mkForce false;
        trusted-users = lib.mkForce [ "root" ];
      };
    };

    services.openssh = {
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };

    system.stateVersion = "26.05";
  };
}
