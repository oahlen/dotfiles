{
  config,
  lib,
  ...
}:
{
  microvm = {
    hypervisor = lib.mkDefault "qemu";
    vcpu = lib.mkDefault 4;
    mem = lib.mkDefault (4 * 1024);

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

    # Relative to the VM state dir (/var/lib/microvms/<name>)
    volumes = [
      {
        image = "store.img";
        mountPoint = "/nix/.rw-store";
        size = 100 * 1024;
      }
      {
        image = "home.img";
        mountPoint = "/home";
        size = 50 * 1024;
      }
    ];

    # QEMU user-mode NAT, no host network setup needed
    interfaces = [
      {
        type = "user";
        id = "vm-${config.networking.hostName}";
        mac = "02:00:00:00:00:01";
      }
    ];

    vsock.ssh.enable = true;
  };

  # The guest nix database must persist alongside the overlay upper dir,
  # otherwise paths in the overlay are unregistered after reboot
  fileSystems."/nix/var" = {
    device = "/nix/.rw-store/var";
    fsType = "none";
    options = [
      "bind"
      "x-systemd.requires-mounts-for=/nix/.rw-store"
    ];
    depends = [ "/nix/.rw-store" ];
    neededForBoot = true;
  };

  # Mount /home before activation creates user home directories, otherwise
  # they end up on the tmpfs root and get hidden by the volume mount
  fileSystems."/home".neededForBoot = true;

  systemd.tmpfiles.rules = [ "d /nix/.rw-store/var 0755 root root -" ];

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
    # Keep host keys on a persistent volume, /etc lives on the tmpfs root
    hostKeys = [
      {
        path = "/nix/.rw-store/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];

    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  system.stateVersion = "26.05";
}
