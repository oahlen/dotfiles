{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.fish;
in
{
  options.programs.fish.enable = lib.mkEnableOption "fish.";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.fish ];

    xdg.config.files = {
      "fish" = {
        source = ./config;
        recursive = true;
      };
    };
  };
}
