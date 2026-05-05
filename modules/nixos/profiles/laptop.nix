{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.profiles.laptop;
in
{
  options.profiles.laptop.enable = lib.mkEnableOption "laptop profile.";

  config = lib.mkIf cfg.enable {
    profiles = {
      desktop.enable = true; # Laptop profile is a superset of the desktop profile
    };

    powerManagement.powertop.enable = true;

    services = {
      fwupd.enable = true;
      hardware.bolt.enable = true;
      thermald.enable = true;
      upower.enable = true;
    };

    environment.systemPackages = [ pkgs.powertop ];
  };
}
