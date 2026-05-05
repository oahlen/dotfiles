{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.waybar;

  inherit (import ./shared.nix { inherit config lib; })
    mkWaylandService
    mkWaylandSystemdTargetOption
    ;
in
{
  options.services.waybar = {
    enable = lib.mkEnableOption "Waybar, a highly customizable Wayland bar for Sway and Wlroots based compositors.";
    package = lib.mkPackageOption pkgs "waybar" { };
    systemd.target = mkWaylandSystemdTargetOption { };

    extraPackages = lib.mkOption {
      type = with lib.types; listOf package;
      default = [ ];
      description = "Extra packages that should be visible to waybar.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    systemd.user.services.waybar = mkWaylandService {
      description = "Highly customizable Wayland bar for Sway and Wlroots based compositors";
      inherit (cfg.systemd) target;
      execStart = lib.getExe cfg.package;
      path = cfg.extraPackages;
    };
  };
}
