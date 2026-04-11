{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.laptop;
in
{
  options.modules.laptop.enable = lib.mkEnableOption "laptop related features.";

  config = lib.mkIf cfg.enable {
    modules = {
      desktop.enable = true; # laptop profile is a superset of the desktop feature set
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
