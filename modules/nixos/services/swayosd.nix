{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.swayosd;
  shared = import ./shared.nix { inherit config lib; };
in
{
  options.modules.swayosd = {
    enable = lib.mkEnableOption "swayosd, a GTK based on screen display for keyboard shortcuts like caps-lock and volume.";
    package = lib.mkPackageOption pkgs "swayosd" { };
    systemd.target = shared.mkWaylandSystemdTargetOption { };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    systemd.user.services.swayosd = shared.mkWaylandService {
      description = "Volume/backlight OSD indicator";
      documentation = [ "man:swayosd(1)" ];
      inherit (cfg.systemd) target;
      execStart = "${cfg.package}/bin/swayosd-server";
    };
  };
}
