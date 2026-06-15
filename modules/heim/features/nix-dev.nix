{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.nix-dev;
in
{
  options.features.nix-dev.enable = lib.mkEnableOption "Nix development programs.";

  config = lib.mkIf cfg.enable {
    programs = {
      direnv.enable = true;
    };

    home.packages = with pkgs; [
      nixfmt-tree
      nix-prefetch-git
      nix-search-cli
      nix-tree
      npins
      nvfetcher
      statix
    ];
  };
}
