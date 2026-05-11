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
    packages = [ pkgs.fish ];

    xdg.config.files = {
      "fish/conf.d".source = ./conf.d;
      "fish/config.fish".source = ./config.fish;
      "fish/functions".source = ./functions;
    };
  };
}
