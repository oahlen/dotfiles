{ ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "desktop";

  defaultUser = {
    name = "oahlen";
    description = "Oscar Ahlén";
  };

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

    microvm.vms = [
      "devbox"
      "sandbox"
    ];

    syncthing.enable = true;
    tailscale.enable = true;
    window-manager.enable = true;
    yubikey.enable = true;
  };

  services = {
    flatpak.enable = true;
  };

  fileSystems."/mnt/backup".options = [
    "noatime"
    "nodiratime"
  ];

  system.stateVersion = "22.11";
}
