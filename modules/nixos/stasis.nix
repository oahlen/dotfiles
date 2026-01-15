{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.stasis;
  shared = import ./../shared/services.nix { inherit config lib; };
in
{
  options.modules.stasis = {
    enable = mkEnableOption "Whether to enable Stasis, a modern idle manager for Wayland";
    package = lib.mkPackageOption pkgs "stasis" { };
    systemd.target = shared.mkWaylandSystemdTargetOption { };

    extraPackages = lib.mkOption {
      type = with lib.types; listOf package;
      default = [ ];
      description = "Extra packages that should be visible to stasis.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    systemd.user.services.stasis = shared.mkWaylandService {
      description = "Stasis Wayland Idle Manager";
      inherit (cfg.systemd) target;
      execStart = lib.getExe cfg.package;
      path = cfg.extraPackages;
    };
  };
}
