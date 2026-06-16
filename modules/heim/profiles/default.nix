{
  config,
  lib,
  ...
}:
let
  cfg = config.profiles.default;
in
{
  options.profiles.default.enable = lib.mkEnableOption "the default profile.";

  config = lib.mkIf cfg.enable {
    features = {
      cli.enable = true;
      nix-dev.enable = true;
      scripts.enable = true;
    };
  };
}
