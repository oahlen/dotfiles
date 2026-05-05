{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.polkit-soteria;

  inherit (import ./shared.nix { inherit config lib; })
    mkWaylandService
    mkWaylandSystemdTargetOption
    ;
in
{
  options.services.polkit-soteria = {
    enable = lib.mkEnableOption "Soteria, a Polkit authentication agent for any desktop environment.";
    package = lib.mkPackageOption pkgs "soteria" { };
    systemd.target = mkWaylandSystemdTargetOption { };
  };

  config = lib.mkIf cfg.enable {
    security.polkit.enable = true;
    environment.systemPackages = [ cfg.package ];

    systemd.user.services.polkit-soteria = mkWaylandService {
      description = "Soteria, Polkit authentication agent for any desktop environment";
      inherit (cfg.systemd) target;
      execStart = lib.getExe cfg.package;
    };
  };
}
