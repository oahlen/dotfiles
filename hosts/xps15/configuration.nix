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
    niri.enable = true;
    podman.enable = true;
    tailscale.enable = true;
    yubikey.enable = true;
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
