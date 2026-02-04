{
  config,
  pkgs,
  ...
}:
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
    development.enable = true;
    gnome.enable = true;
    laptop.enable = true;
    niri.enable = true;
    podman.enable = true;
    virt-manager.enable = true;
  };

  environment.systemPackages = with pkgs; [
    _1password-gui
    filen-cli
    nodejs
    config.packages.rbw-wrapped
  ];

  system.stateVersion = "25.05";
}
