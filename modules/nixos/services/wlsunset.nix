{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.wlsunset;

  inherit (import ./shared.nix { inherit config lib; })
    mkWaylandService
    mkWaylandSystemdTargetOption
    ;
in
{
  options.services.wlsunset = {
    enable = lib.mkEnableOption "wlsunset.";
    package = lib.mkPackageOption pkgs "wlsunset" { };
    systemd.target = mkWaylandSystemdTargetOption { };

    args = lib.mkOption {
      type = with lib.types; listOf str;
      default = [ ];
      description = "Arguments to pass to wlsunset.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    systemd.user.services.wlsunset = mkWaylandService {
      description = "Day/night gamma adjustments for Wayland compositors.";
      inherit (cfg.systemd) target;
      execStart = "${lib.getExe cfg.package} ${lib.escapeShellArgs cfg.args}";
    };
  };
}
