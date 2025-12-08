{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.swayidle;
  shared = import ./../shared/services.nix { inherit config lib; };
in
{
  options.modules.swayidle =
    let
      timeoutModule = _: {
        options = {
          timeout = mkOption {
            type = types.ints.positive;
            example = 60;
            description = "Timeout in seconds.";
          };

          command = mkOption {
            type = types.str;
            description = "Command to run after timeout seconds of inactivity.";
          };

          resumeCommand = mkOption {
            type = with types; nullOr str;
            default = null;
            description = "Command to run when there is activity again.";
          };
        };
      };

      eventModule = _: {
        options = {
          event = mkOption {
            type = types.enum [
              "before-sleep"
              "after-resume"
              "lock"
              "unlock"
            ];
            description = "Event name.";
          };

          command = mkOption {
            type = types.str;
            description = "Command to run when event occurs.";
          };
        };
      };
    in
    {
      enable = mkEnableOption "Whether to enable idle manager for Wayland.";
      package = lib.mkPackageOption pkgs "swayidle" { };
      systemd.target = shared.mkWaylandSystemdTargetOption { };

      timeouts = mkOption {
        type = with types; listOf (submodule timeoutModule);
        default = [ ];
        example = literalExpression ''
          [
            { timeout = 60; command = "''${pkgs.swaylock}/bin/swaylock -fF"; }
            { timeout = 90; command = "''${pkgs.systemd}/bin/systemctl suspend"; }
          ]
        '';
        description = "List of commands to run after idle timeout.";
      };

      events = mkOption {
        type = with types; listOf (submodule eventModule);
        default = [ ];
        example = literalExpression ''
          [
            { event = "before-sleep"; command = "''${pkgs.swaylock}/bin/swaylock -fF"; }
            { event = "lock"; command = "lock"; }
          ]
        '';
        description = "Run command on occurrence of a event.";
      };

      extraArgs = mkOption {
        type = with types; listOf str;
        default = [ "-w" ];
        description = "Extra arguments to pass to swayidle.";
      };

      command = lib.mkOption {
        type = lib.types.str;
        default = "${pkgs.swayidle}/bin/swayidle -w";
      };
    };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    systemd.user.services.swayidle = shared.mkWaylandService {
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
