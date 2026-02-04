{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.swaybg;
  shared = import ../shared/services.nix { inherit config lib; };
in
{
  options.modules.swaybg = {
    enable = mkEnableOption "Whether to enable swaybg, a wallpaper tool for Wayland compositors.";
    package = lib.mkPackageOption pkgs "swaybg" { };

    wallpaper = mkOption {
      type = lib.types.str;
      default = "$WALLPAPER";
      description = "The wallpaper path or environment variable to display.";
    };

    systemd.target = shared.mkWaylandSystemdTargetOption { };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    systemd.user.services.swaybg = shared.mkWaylandService {
      description = "Wallpaper daemon for Wayland";
      documentation = [ "man:swaybg(1)" ];
      inherit (cfg.systemd) target;
      execStart = "${lib.getExe cfg.package} -o * -i ${cfg.wallpaper} -m fit";
    };
  };
}
