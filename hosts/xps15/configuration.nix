{
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

  profiles = {
    home.enable = true;
    laptop.enable = true;
    work.enable = true;
  };

  desktops = {
    gnome.enable = true;
    niri.enable = true;
  };

  features = {
    containers.enable = true;
    security-key.enable = true;
  };

  users.users.oahlen = {
    uid = 1000;
    description = "Oscar Ahlén";
    isNormalUser = true;
    extraGroups = [
      "users"
      "wheel"
    ];

    heim = import ./home.nix { inherit pkgs; };
  };

  system.stateVersion = "25.11";
}
