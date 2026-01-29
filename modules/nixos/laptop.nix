{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.laptop;
in
{
  options.modules.laptop.enable = mkEnableOption "Whether to enable laptop related features.";

  config = mkIf cfg.enable {
    modules = {
      desktop.enable = true; # laptop profile is a superset of the desktop feature set
      kanshi.enable = config.modules.niri.enable;
    };

    powerManagement.powertop.enable = true;

    services = {
      fwupd.enable = true;
      hardware.bolt.enable = true;
      thermald.enable = true;
    };

    environment.systemPackages = [ pkgs.powertop ];
  };
}
