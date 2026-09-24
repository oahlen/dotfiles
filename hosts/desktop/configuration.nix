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
    amdgpu = {
      initrd.enable = true;
      overdrive.enable = true;
    };
  };

  profiles = {
    desktop.enable = true;
  };

  features = {
    browser.httpAllowlist = [
      "192.168.1.100"
    ];

    gaming.enable = true;
    podman.enable = true;
    syncthing.enable = true;
    tailscale.enable = true;
    window-manager.enable = true;
    yubikey.enable = true;
  };

  environment.systemPackages = with pkgs; [
    chromium
    nfs-utils
  ];

  fileSystems."/mnt/backup".options = [
    "noatime"
    "nodiratime"
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
