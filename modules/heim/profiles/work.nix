{
  config,
  lib,
  ...
}:
let
  cfg = config.profiles.work;
in
{
  options.profiles.work.enable = lib.mkEnableOption "work profile.";

  config = lib.mkIf cfg.enable {
    programs = {
      one-password.enable = true;
    };
  };
}
