{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "xps15";

  boot = {
    loader.systemd-boot.enable = true;
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

  powerManagement.powertop.enable = true;

  modules = {
    gnome.enable = true;
    kanshi.enable = true;
    niri.enable = true;
    podman.enable = true;
    tailscale.enable = true;
    virt-manager.enable = true;
    yubikey.enable = true;
  };

  services = {
    flatpak.enable = true;
    fstrim.enable = true;
    fwupd.enable = true;
    hardware.bolt.enable = true;
    power-profiles-daemon.enable = true;
    thermald.enable = true;
  };

  environment.systemPackages = with pkgs; [
    _1password-gui
    fastfetch
    nodejs
    powertop
    rbw-wrapped
  ];

  fileSystems."/".options = [
    "noatime"
    "nodiratime"
    "discard"
  ];

  system.stateVersion = "25.05";
}
