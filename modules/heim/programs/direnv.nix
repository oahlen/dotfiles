{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.direnv;
in
{
  options.programs.direnv.enable = lib.mkEnableOption "direnv with nix-direnv integration.";

  config = lib.mkIf cfg.enable {
    packages = [ pkgs.direnv ];

    xdg.config.files = {
      "direnv/direnvrc".text = ''
        source ${pkgs.nix-direnv}/share/nix-direnv/direnvrc
      '';
    };
  };
}
