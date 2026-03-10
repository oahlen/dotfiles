{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.nix.gc;
in
{
  options.nix.gc.user = mkEnableOption "Whether to enable nix garbage collection for the current user.";

  config = {
    systemd.user.services.nix-gc = mkIf cfg.user {
      description = "Nix Garbage Collector";
      script = "exec ${config.nix.package.out}/bin/nix-collect-garbage ${cfg.options}";
      serviceConfig.Type = "oneshot";
      startAt = optionals cfg.automatic cfg.dates;
      # do not start and delay when switching
      restartIfChanged = false;
    };

    systemd.user.timers.nix-gc = mkIf cfg.user {
      timerConfig = {
        RandomizedDelaySec = cfg.randomizedDelaySec;
        Persistent = cfg.persistent;
      };
    };
  };
}
