{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.fuzzel;

  base = {
    main = {
      dpi-aware = "no";
      font = "JetBrainsMono Nerd Font:size=11.5";
      horizontal-pad = 24;
      icons-enabled = "no";
      inner-pad = 8;
      line-height = 16;
      prompt = "> ";
      terminal = "foot -e";
      use-bold = "yes";
      vertical-pad = 20;
      width = 40;
    };

    border = {
      radius = 8;
      width = 2;
    };
  };

  withAlpha = color: "${lib.removePrefix "#" color}ff";

  mkColors = variant: {
    background = withAlpha variant.background;
    border = withAlpha variant.cyan;
    input = withAlpha variant.foreground;
    match = withAlpha variant.yellow;
    prompt = withAlpha variant.green;
    selection = withAlpha variant.selection.background;
    selection-match = withAlpha variant.selection.highlight;
    selection-text = withAlpha variant.selection.foreground;
    text = withAlpha variant.foreground;
  };
in
{
  options.programs.fuzzel.enable = lib.mkEnableOption "fuzzel.";

  config = lib.mkIf cfg.enable {
    packages = [ pkgs.fuzzel ];

    xdg.config.files = {
      "fuzzel/fuzzel.ini".variants = {
        dark = {
          text = lib.generators.toINI { } (base // { colors = mkColors config.colors.dark; });
          default = config.colorscheme.default == "dark";
        };

        light = {
          text = lib.generators.toINI { } (base // { colors = mkColors config.colors.light; });
          default = config.colorscheme.default == "light";
        };
      };
    };
  };
}
