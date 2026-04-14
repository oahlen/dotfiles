{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./home.nix
  ];

  networking.hostName = "desktop";

  boot.kernelPackages = pkgs.linuxPackages_zen;

  hardware = {
    amdgpu.initrd.enable = true;
    bluetooth.enable = true;
  };

  modules = {
    desktop.enable = true;
    development.enable = true;
    gaming.enable = true;
    niri.enable = true;
    podman.enable = true;
  };

  environment.systemPackages = with pkgs; [
    customPackages.hytale-launcher
    customPackages.rbw
    filen-cli
  ];

  fileSystems."/mnt/backup".options = [
    "noatime"
    "nodiratime"
    "discard"
  ];

  system.stateVersion = "22.11";
}
