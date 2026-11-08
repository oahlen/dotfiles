{ config, lib, ... }:
let
  cfg = config.features.persistence;
in
{
  options.features.persistence.enable = lib.mkEnableOption "persistent VM state that survives reboots.";

  config = lib.mkIf cfg.enable {
    # Relative to the VM state dir (/var/lib/microvms/<name>)
    microvm.volumes = [
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

    # Keep host keys on a persistent volume, /etc lives on the tmpfs root
    services.openssh.hostKeys = [
      {
        path = "/nix/.rw-store/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };
}
