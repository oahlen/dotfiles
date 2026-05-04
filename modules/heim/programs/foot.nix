{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.foot;

  stripHash = lib.removePrefix "#";

  mkColors = variant: {
    background = stripHash variant.background;
    foreground = stripHash variant.foreground;
    regular0 = stripHash variant.black;
    regular1 = stripHash variant.red;
    regular2 = stripHash variant.green;
    regular3 = stripHash variant.yellow;
    regular4 = stripHash variant.blue;
    regular5 = stripHash variant.purple;
    regular6 = stripHash variant.cyan;
    regular7 = stripHash variant.white;
    bright0 = stripHash variant.bright-black;
    bright1 = stripHash variant.bright-red;
    bright2 = stripHash variant.bright-green;
    bright3 = stripHash variant.bright-yellow;
    bright4 = stripHash variant.bright-blue;
    bright5 = stripHash variant.bright-purple;
    bright6 = stripHash variant.bright-cyan;
    bright7 = stripHash variant.bright-white;
    selection-background = stripHash variant.selection.background;
    selection-foreground = stripHash variant.selection.foreground;
  };

  mkConfig = theme: {
    main = {
      dpi-aware = "no";
      font = "JetBrainsMono Nerd Font:size=11.5";
      shell = "${lib.getExe pkgs.fish}";
      initial-color-theme = "${theme}";
      pad = "10x10";
      term = "xterm-256color";
    };

    colors-dark = mkColors config.colors.dark;
    colors-light = mkColors config.colors.light;
  };
in
{
  options.programs.foot.enable = lib.mkEnableOption "foot.";

  config = lib.mkIf cfg.enable {
    packages = [ pkgs.foot ];

    xdg.config.files = {
      "foot/foot.ini".variants = {
        dark = {
          text = lib.generators.toINI { } (mkConfig "dark");
          default = config.colorscheme.default == "dark";
        };

        light = {
          text = lib.generators.toINI { } (mkConfig "light");
          default = config.colorscheme.default == "light";
        };
      };
    };
  };
}
