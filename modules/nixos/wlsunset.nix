{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.wlsunset;
  shared = import ./../shared/services.nix { inherit config lib; };
in
{
  options.modules.wlsunset = {
    enable = mkEnableOption "Whether to enable wlsunset.";
    package = lib.mkPackageOption pkgs "wlsunset" { };
    systemd.target = shared.mkWaylandSystemdTargetOption { };

    args = mkOption {
      type = with types; listOf str;
      default = [ ];
      description = "Arguments to pass to wlsunset.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    systemd.user.services.wlsunset = shared.mkWaylandService {
      description = "Day/night gamma adjustments for Wayland compositors.";
      inherit (cfg.systemd) target;
      execStart = "${lib.getExe cfg.package} ${lib.escapeShellArgs cfg.args}";
    };
  };
}
