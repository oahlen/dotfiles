{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.modules.polkit-soteria;
  shared = import ./../shared/services.nix { inherit config lib; };
in
{
  options.modules.polkit-soteria = {
    enable = mkEnableOption "Whether to enable Soteria, a Polkit authentication agent for any desktop environment.";
    package = lib.mkPackageOption pkgs "soteria" { };
    systemd.target = shared.mkWaylandSystemdTargetOption { };
  };

  config = lib.mkIf cfg.enable {
    security.polkit.enable = true;
    environment.systemPackages = [ cfg.package ];

    systemd.user.services.polkit-soteria = {
      description = "Soteria, Polkit authentication agent for any desktop environment";

      wantedBy = [ cfg.systemd.target ];
      wants = [ cfg.systemd.target ];
      after = [ cfg.systemd.target ];

      script = lib.getExe cfg.package;
      serviceConfig = {
        Type = "simple";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
