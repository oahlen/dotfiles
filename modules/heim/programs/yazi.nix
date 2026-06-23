{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.yazi;
  generateToml = (pkgs.formats.toml { }).generate;

  package = pkgs.yazi.override { optionalDeps = [ pkgs._7zz ]; };

  yazi = {
    mgr = {
      show_hidden = true;
      sort_dir_first = true;
    };
  };

  theme = {
    mgr = {
      syntect_theme = "${pkgs.customPackages.base16-theme}/base16.tmTheme";
      border_style = {
        fg = "DarkGray";
      };
      count_copied = {
        bg = "Green";
        fg = "Black";
      };
      count_cut = {
        bg = "Red";
        fg = "Black";
      };
      count_selected = {
        bg = "Yellow";
        fg = "Black";
      };
      cwd = {
        fg = "Yellow";
      };
    };

    mode = {
      normal_alt = {
        bg = "DarkGray";
        fg = "Black";
      };
      normal_main = {
        bg = "Blue";
        bold = true;
        fg = "Black";
      };
      select_alt = {
        bg = "DarkGray";
        fg = "Black";
      };
      select_main = {
        bg = "Green";
        bold = true;
        fg = "Black";
      };
      unset_alt = {
        bg = "DarkGray";
        fg = "Black";
      };
      unset_main = {
        bg = "Yellow";
        bold = true;
        fg = "Black";
      };
    };

    status = {
      overall = {
        bg = "Black";
        fg = "White";
      };
    };
  };
in
{
  options.programs.yazi.enable = lib.mkEnableOption "yazi.";

  config = lib.mkIf cfg.enable {
    home.packages = [ package ];

    xdg.config.files = {
      "yazi/yazi.toml".source = generateToml "yazi.toml" yazi;
      "yazi/theme.toml".source = generateToml "theme.toml" theme;
    };
  };
}
