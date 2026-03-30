{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.direnv;
in
{
  options.modules.direnv.enable = lib.mkEnableOption "Whether to enable direnv + nix-direnv integration.";

  config = lib.mkIf cfg.enable {
    environment.packages = [
      pkgs.direnv
      pkgs.nix-direnv
    ];

    pathsToLink = [ "/share/nix-direnv" ];
  };
}
