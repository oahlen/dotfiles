{ pkgs }:
let
  src = pkgs.customPackages.aurora-nvim;
  dark-palette = builtins.fromJSON (builtins.readFile "${src}/aurora-dark-palette.json");
  light-palette = builtins.fromJSON (builtins.readFile "${src}/aurora-light-palette.json");

  mkTheme =
    palette: with palette; {
      foreground = fg1;
      background = bg0;

      inherit
        black
        red
        green
        yellow
        blue
        purple
        cyan
        ;

      white = fg1;

      bright-black = grey;
      bright-red = red;
      bright-green = green;
      bright-yellow = yellow;
      bright-blue = blue;
      bright-purple = purple;
      bright-cyan = cyan;
      bright-white = fg2;

      statusline = {
        foreground = fg2;
        background = statusline_bg;
        inactive = bg2;
        accent = blue;
      };

      selection = {
        foreground = fg2;
        background = bg2;
        highlight = orange;
      };

      diff = {
        added_bg = diff_add_bg;
        deleted_bg = diff_delete_bg;
      };

      overview = dark-palette.statusline_bg;
    };
in
{
  dark = mkTheme dark-palette;
  light = mkTheme light-palette;
}
