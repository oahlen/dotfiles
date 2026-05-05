{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.swayidle;

  inherit (import ./shared.nix { inherit config lib; })
    mkWaylandService
    mkWaylandSystemdTargetOption
    ;

  timeoutModule = _: {
    options = {
      timeout = lib.mkOption {
        type = lib.types.ints.positive;
        example = 60;
        description = "Timeout in seconds.";
      };

      command = lib.mkOption {
        type = lib.types.str;
        description = "Command to run after timeout seconds of inactivity.";
      };

      resumeCommand = lib.mkOption {
        type = with lib.types; nullOr str;
        default = null;
        description = "Command to run when there is activity again.";
      };
    };
  };

  eventModule = _: {
    options = {
      event = lib.mkOption {
        type = lib.types.enum [
          "before-sleep"
          "after-resume"
          "lock"
          "unlock"
        ];
        description = "Event name.";
      };

      command = lib.mkOption {
        type = lib.types.str;
        description = "Command to run when event occurs.";
      };
    };
  };
in
{
  options.services.swayidle = {
    enable = lib.mkEnableOption "idle management for Wayland.";
    package = lib.mkPackageOption pkgs "swayidle" { };
    systemd.target = mkWaylandSystemdTargetOption { };

    timeouts = lib.mkOption {
      type = with lib.types; listOf (submodule timeoutModule);
      default = [ ];
      example = lib.literalExpression ''
        [
          { timeout = 60; command = "''${pkgs.swaylock}/bin/swaylock -fF"; }
          { timeout = 90; command = "''${pkgs.systemd}/bin/systemctl suspend"; }
        ]
      '';
      description = "List of commands to run after idle timeout.";
    };

    events = lib.mkOption {
      type = with lib.types; listOf (submodule eventModule);
      default = [ ];
      example = lib.literalExpression ''
        [
          { event = "before-sleep"; command = "''${pkgs.swaylock}/bin/swaylock -fF"; }
          { event = "lock"; command = "lock"; }
        ]
      '';
      description = "Run command on occurrence of a event.";
    };

    extraArgs = lib.mkOption {
      type = with lib.types; listOf str;
      default = [ "-w" ];
      description = "Extra arguments to pass to swayidle.";
    };

    command = lib.mkOption {
      type = lib.types.str;
      default = "${pkgs.swayidle}/bin/swayidle -w";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    systemd.user.services.swayidle = mkWaylandService {
      description = "Idle manager for Wayland";
      documentation = [ "man:swayidle(1)" ];
      inherit (cfg.systemd) target;

      execStart =
        let
          mkTimeout =
            t:
            [
              "timeout"
              (toString t.timeout)
              t.command
            ]
            ++ lib.optionals (t.resumeCommand != null) [
              "resume"
              t.resumeCommand
            ];

          mkEvent = e: [
            e.event
            e.command
          ];

          args =
            cfg.extraArgs ++ (lib.concatMap mkTimeout cfg.timeouts) ++ (lib.concatMap mkEvent cfg.events);
        in
        "${lib.getExe cfg.package} ${lib.escapeShellArgs args}";

      extraServiceConfig = {
        # swayidle executes commands using "sh -c", so the PATH needs to contain a shell.
        Environment = [ "PATH=${lib.makeBinPath [ pkgs.bash ]}" ];
      };
    };
  };
}
