{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.waybar;
  shared = import ./../shared/services.nix { inherit config lib; };
in
{
  options.modules.waybar = {
    enable = mkEnableOption "Whether to enable waybar, a highly customizable Wayland bar for Sway and Wlroots based compositors.";
    package = lib.mkPackageOption pkgs "waybar" { };
    systemd.target = shared.mkWaylandSystemdTargetOption { };

    extraPackages = lib.mkOption {
      type = with lib.types; listOf package;
      default = [ ];
      description = "Extra packages that should be visible to waybar.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    systemd.user.services.waybar = shared.mkWaylandService {
      description = "Highly customizable Wayland bar for Sway and Wlroots based compositors";
      inherit (cfg.systemd) target;
      execStart = lib.getExe cfg.package;
      path = cfg.extraPackages;
    };
  };
}
