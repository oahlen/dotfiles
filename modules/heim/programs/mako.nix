{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    concatStringsSep
    mapAttrsToList
    ;

  cfg = config.programs.mako;

  base = {
    font = "JetBrainsMono Nerd Font 11.5";

    anchor = "top-right";
    default-timeout = 10000;
    ignore-timeout = true;

    margin = 24;
    padding = 16;

    border-radius = 8;
    border-size = 2;
  };

  mkColors = variant: {
    background-color = variant.background;
    border-color = variant.cyan;
    progress-color = variant.statusline.inactive;
    text-color = variant.foreground;
  };

  formatValue = v: if builtins.isBool v then if v then "true" else "false" else toString v;

  mkConfig = cfg: concatStringsSep "\n" (mapAttrsToList (k: v: "${k}=${formatValue v}") cfg);
in
{
  options.programs.mako.enable = lib.mkEnableOption "mako.";

  config = lib.mkIf cfg.enable {
    packages = [ pkgs.mako ];

    xdg.config.files = {
      "mako/config".variants = {
        dark = {
          text = mkConfig (base // mkColors config.colors.dark);
          default = config.colorscheme.default == "dark";
        };

        light = {
          text = mkConfig (base // mkColors config.colors.light);
          default = config.colorscheme.default == "light";
        };
      };
    };
  };
}
