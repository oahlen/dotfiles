{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.development;
in
{
  options.modules.development.enable = lib.mkEnableOption "Whether to enable basic development features.";

  config = lib.mkIf cfg.enable {
    modules.packages.enable = true;

    programs = {
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      git.enable = true;
    };
  };
}
