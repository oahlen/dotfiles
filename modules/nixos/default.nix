{
  config,
  pkgs,
  ...
}:
{
  # Nixpkgs settings
  # nixpkgs.config.allowUnfree = true;

  # Boot settings
  boot = {
    kernel.sysctl = {
      "vm.swappiness" = 10;
      "vm.vfs_cache_pressure" = 50;
      "vm.max_map_count" = 16777216;
    };

    loader.efi.canTouchEfiVariables = true;
  };

  # Hardware settings
  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
  };

  # Timezone
  time.timeZone = "Europe/Stockholm";

  # Input settings
  console.keyMap = "sv-latin1";

  # Internationalization
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "sv_SE.UTF-8";
      LC_IDENTIFICATION = "sv_SE.UTF-8";
      LC_MEASUREMENT = "sv_SE.UTF-8";
      LC_MONETARY = "sv_SE.UTF-8";
      LC_NAME = "sv_SE.UTF-8";
      LC_NUMERIC = "sv_SE.UTF-8";
      LC_PAPER = "sv_SE.UTF-8";
      LC_TELEPHONE = "sv_SE.UTF-8";
      LC_TIME = "sv_SE.UTF-8";
    };
  };

  # Security settings
  security = {
    sudo.enable = false;
    sudo-rs.enable = true;
  };

  # Systemd settings
  services.journald.extraConfig = ''
    SystemMaxUse=100M
  '';

  # User configuration
  users.users.${config.user.name} = {
    uid = 1000;
    description = config.user.fullName;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  environment = {
    # Environment variables
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    # System packages
    systemPackages = import ../../shared/packages.nix pkgs;
  };

  # Common programs and packages
  programs.git.enable = true;

  # General overrides
  networking.networkmanager.wifi.backend = "iwd";
  services.dbus.implementation = "broker";
}
