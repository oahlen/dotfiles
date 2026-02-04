{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.development;
in
{
  options.modules.development.enable = mkEnableOption "Whether to enable basic development features.";

  config = mkIf cfg.enable {
    programs = {
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      git.enable = true;
    };

    environment.systemPackages = import ../../shared/packages.nix { inherit pkgs; };
  };
}
