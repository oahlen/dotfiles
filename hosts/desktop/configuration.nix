{ pkgs, ... }:
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

  environment.systemPackages = [ pkgs.nfs-utils ];

  fileSystems."/mnt/backup".options = [
    "noatime"
    "nodiratime"
    "discard"
  ];

  users.users.oahlen = {
    uid = 1000;
    description = "Oscar Ahlén";
    isNormalUser = true;
    extraGroups = [
      "audio"
      "gamemode"
      "video"
      "wheel"
    ];

    heim = import ./home.nix { inherit pkgs; };
  };

  system.stateVersion = "22.11";
}
