{
  config,
  lib,
  ...
}:
let
  cfg = config.nix.gc;
in
{
  options.nix.gc.user = lib.mkEnableOption "Nix garbage collection for the current user.";

  config = {
    systemd.user.services.nix-gc = lib.mkIf cfg.user {
      description = "Nix Garbage Collector";
      script = "exec ${config.nix.package.out}/bin/nix-collect-garbage ${cfg.options}";
      serviceConfig.Type = "oneshot";
      startAt = lib.optionals cfg.automatic cfg.dates;
      # do not start and delay when switching
      restartIfChanged = false;
    };

    systemd.user.timers.nix-gc = lib.mkIf cfg.user {
      timerConfig = {
        RandomizedDelaySec = cfg.randomizedDelaySec;
        Persistent = cfg.persistent;
      };
    };
  };
}
