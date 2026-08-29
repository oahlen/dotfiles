{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.noctalia;
  toml = pkgs.formats.toml { };

  switch-theme = pkgs.callPackage ./switch-theme.nix {
    inherit (config.colorscheme) default;
  };

  mkPalette = import ./palette.nix;

  palette = {
    dark = mkPalette { variant = config.colors.dark; };
    light = mkPalette { variant = config.colors.light; };
  };

  conf = {
    bar.default = {
      center = [
        "clock"
        "media"
      ];
      concave_edge_corners = false;
      end = [
        "keyboard_layout"
        "notifications"
        "clipboard"
        "network"
        "bluetooth"
        "volume"
        "brightness"
        "battery"
        "control-center"
        "session"
      ];
      font_weight = 400;
      margin_edge = 8;
      margin_ends = 8;
      padding = 12;
      radius = 8;
      shadow = false;
      start = [
        "launcher"
        "workspaces"
      ];
      thickness = 32;
      widget_spacing = 8;
    };

    control_center = {
      width = 800;

      calendar.show_week_numbers = true;
    };

    desktop_widgets.enabled = false;

    idle = {
      behavior_order = [
        "lock"
        "screen-off"
        "lock-and-suspend"
      ];

      behavior = {
        lock = {
          action = "lock";
          enabled = true;
          timeout = 600.0;
        };

        lock-and-suspend = {
          action = "lock_and_suspend";
          enabled = true;
          timeout = 1800.0;
        };

        screen-off = {
          action = "screen_off";
          enabled = true;
          timeout = 900.0;
        };
      };
    };

    nightlight = {
      enabled = true;
      temperature_night = 5000;
    };

    shell = {
      animation.enabled = false;
      launcher.show_icons = false;
      panel.control_center_placement = "floating";
    };

    theme = {
      custom_palette = "aurora";
      source = "custom";
    };

    wallpaper = {
      directory = "/home/oahlen/Pictures/Wallpapers";
      default.path = "/home/oahlen/Pictures/Wallpapers/buck.jpg";
    };

    widget = {
      clock.format = "{:%d %B %H:%M}";
      workspaces.style = "minimal";
    };
  };
in
{
  options.programs.noctalia.enable = lib.mkEnableOption "noctalia.";

  config = lib.mkIf cfg.enable {
    home.packages = [ switch-theme ];

    xdg.config.files = {
      "noctalia/palettes/aurora.json".text = lib.generators.toJSON { } palette;

      "noctalia/config.toml".source = toml.generate "config.toml" conf;
    };
  };
}
