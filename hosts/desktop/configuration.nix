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

  boot.kernelPackages = pkgs.linuxPackages_zen;

  hardware = {
    amdgpu.initrd.enable = true;
    bluetooth.enable = true;
  };

  modules = {
    desktop.enable = true;
    gaming.enable = true;
    niri.enable = true;
    podman.enable = true;
  };

  environment.systemPackages = with pkgs; [
    filen-cli
    config.packages.hytale-launcher
    config.packages.rbw-wrapped
  ];

  fileSystems."/mnt/backup".options = [
    "noatime"
    "nodiratime"
    "discard"
  ];

  system.stateVersion = "22.11";
}
