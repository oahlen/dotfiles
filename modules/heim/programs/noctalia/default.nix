{
  config,
  lib,
  ...
}:
let
  cfg = config.programs.noctalia;
in
{
  options.programs.noctalia.enable = lib.mkEnableOption "noctalia.";

  config = lib.mkIf cfg.enable {
    home.packages = [ ];

    xdg.config.files = {
      "noctalia/config.toml".text = ''
        [bar.default]
        center = [ "clock", "media" ]
        concave_edge_corners = false
        end = [
            "keyboard_layout",
            "notifications",
            "clipboard",
            "network",
            "bluetooth",
            "volume",
            "brightness",
            "battery",
            "control-center",
            "session"
        ]
        font_weight = 400
        margin_edge = 8
        margin_ends = 8
        padding = 12
        radius = 8
        shadow = false
        start = [ "launcher", "workspaces" ]
        thickness = 32
        widget_spacing = 8

        [control_center]
        width = 800

            [control_center.calendar]
            show_week_numbers = true

        [desktop_widgets]
        enabled = false

        [idle]
        behavior_order = [ "lock", "screen-off", "lock-and-suspend" ]

            [idle.behavior.lock]
            action = "lock"
            enabled = true
            timeout = 600.0

            [idle.behavior.lock-and-suspend]
            action = "lock_and_suspend"
            enabled = true
            timeout = 1800.0

            [idle.behavior.screen-off]
            action = "screen_off"
            enabled = true
            timeout = 900.0

        [nightlight]
        enabled = true
        temperature_night = 5000

        [shell.animation]
        enabled = false

        [shell.launcher]
        show_icons = false

        [shell.panel]
        control_center_placement = "floating"

        [theme]
        custom_palette = "aurora"
        source = "custom"

        [wallpaper]
        directory = "/home/oahlen/Pictures/Wallpapers"

            [wallpaper.default]
            path = "/home/oahlen/Pictures/Wallpapers/buck.jpg"

        [widget.clock]
        format = "{:%d %B %H:%M}"

        [widget.workspaces]
        style = "minimal"
      '';
    };
  };
}
