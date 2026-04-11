{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.development;
in
{
  options.modules.development.enable = lib.mkEnableOption "basic development features.";

  config = lib.mkIf cfg.enable {
    programs = {
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      git.enable = true;
    };

    environment.systemPackages = [ pkgs.customPackages.environment ];
  };
}
