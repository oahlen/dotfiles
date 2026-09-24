{
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "xps15";

  defaultUser = {
    name = "oahlen";
    description = "Oscar Ahlén";
  };

  boot = {
    blacklistedKernelModules = [ "nouveau" ];
    initrd.kernelModules = [ "i915" ];
  };

  hardware = {
    graphics.extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver
      vpl-gpu-rt
    ];
  };

  profiles = {
    laptop.enable = true;
    work.enable = true;
  };

  features = {
    podman.enable = true;
    syncthing.enable = true;
    tailscale.enable = true;
    window-manager.enable = true;
    yubikey.enable = true;
  };

  services = {
    flatpak.enable = true;
  };

  system.stateVersion = "25.11";
}
