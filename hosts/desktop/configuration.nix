{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "desktop";

  boot = {
    loader.systemd-boot.enable = true;
    kernelPackages = pkgs.linuxPackages_zen;
    kernelModules = [ "amdgpu" ];
  };

  hardware.bluetooth.enable = true;

  modules = {
    gaming.enable = true;
    niri.enable = true;
    podman.enable = true;
    tailscale.enable = true;
    yubikey.enable = true;
  };

  services = {
    flatpak.enable = true;
    fstrim.enable = true;
    power-profiles-daemon.enable = true;
  };

  environment.systemPackages = with pkgs; [
    fastfetch
    filen-cli
    nfs-utils
    config.packages.rbw-wrapped
  ];

  fileSystems = {
    "/".options = [
      "noatime"
      "nodiratime"
      "discard"
    ];
    "/mnt/backup".options = [
      "noatime"
      "nodiratime"
      "discard"
    ];
  };

  system.stateVersion = "22.11";
}
