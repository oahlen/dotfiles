{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.yazi;

  package = pkgs.yazi.override { optionalDeps = [ pkgs._7zz ]; };
in
{
  options.programs.yazi.enable = lib.mkEnableOption "yazi.";

  config = lib.mkIf cfg.enable {
    home.packages = [ package ];

    xdg.config.files = {
      "yazi/yazi.toml".source = ./yazi.toml;
      "yazi/theme.toml".source = ./theme.toml;
    };
  };
}
