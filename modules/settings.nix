{
  config,
  lib,
  pkgs,
  ...
}:
{
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
    inputMethod.enable = false;
  };

  # Nix settings

  # Enable if nixpkgs.pkgs is not set
  # nixpkgs.config.allowUnfree = true;

  nix = {
    channel.enable = false;

    settings = {
      auto-optimise-store = true;
      experimental-features = "nix-command flakes";
      use-xdg-base-directories = true;
    };

    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
    '';

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  environment.variables.NIX_PATH = lib.mkForce "nixpkgs=${pkgs.path}";

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

  # Global environment variables
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # General overrides
  networking.networkmanager.wifi.backend = "iwd";
  services.dbus.implementation = "broker";
}
