{
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "desktop";

  hardware = {
    amdgpu.initrd.enable = true;
    amdgpu.overdrive.enable = true;
  };

  profiles = {
    desktop.enable = true;
  };

  features = {
    chromium.httpAllowlist = [
      "192.168.1.100"
    ];

    gaming.enable = true;
    niri.enable = true;
    podman.enable = true;
    tailscale.enable = true;
    yubikey.enable = true;
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
      "users"
      "wheel"
    ];
  };

  system.stateVersion = "22.11";
}
