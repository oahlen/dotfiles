{
  config,
  lib,
  pkgs-unstable,
  ...
}:
let
  cfg = config.services.noctalia;
in
{
  options.services.noctalia = {
    enable = lib.mkEnableOption "noctalia, a sleek and customizable desktop shell for Wayland";

    package = lib.mkPackageOption pkgs-unstable "noctalia" { };

    systemd.target = lib.mkOption {
      type = lib.types.str;
      description = "Systemd target to bind to.";
      default = config.wayland.systemd.target;
      defaultText = lib.literalExpression "config.wayland.systemd.target";
      example = "sway-session.target";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    systemd.user.services.noctalia = {
      description = "Noctalia Wayland desktop shell";
      documentation = [ "https://docs.noctalia.dev/v5/" ];
      partOf = [ cfg.systemd.target ];
      after = [ cfg.systemd.target ];
      wantedBy = [ cfg.systemd.target ];

      enableDefaultPath = false;

      unitConfig = {
        ConditionEnvironment = "WAYLAND_DISPLAY";
      };

      serviceConfig = {
        ExecStart = lib.getExe cfg.package;
        Restart = "on-failure";
      };
    };

    networking.networkmanager.enable = lib.mkDefault true;
    hardware.bluetooth.enable = lib.mkDefault true;
    services.upower.enable = lib.mkDefault true;
    services.power-profiles-daemon.enable = lib.mkDefault true;
  };
}
