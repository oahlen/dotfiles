{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "xps15";

  boot = {
    blacklistedKernelModules = [ "nouveau" ];
    initrd.kernelModules = [ "i915" ];
  };

  hardware = {
    bluetooth.enable = true;

    graphics.extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver
      vpl-gpu-rt
    ];
  };

  modules = {
    gnome.enable = true;
    intune.enable = true;
    laptop.enable = true;
    niri.enable = true;
    podman.enable = true;
  };

  users.users.oahlen = {
    uid = 1000;
    description = "Oscar Ahlén";
    isNormalUser = true;
    extraGroups = [
      "audio"
      # "libvirtd"
      "video"
      "wheel"
    ];

    packages = with pkgs; [
      _1password-gui
      customPackages.rbw
      filen-cli
    ];
  };

  system.stateVersion = "25.11";
}
