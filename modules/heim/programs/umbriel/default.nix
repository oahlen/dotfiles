{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.umbriel;
  toml = pkgs.formats.toml { };

  defaultSettings = {
    general = {
      autostart = [ "systemctl --user start umbriel-session.target" ];
      show_cheatsheet = false;
    };

    appearance = {
      border_width = 2;
      corner_radius = 8;
    };

    input = {
      keyboard = {
        layout = "us,se";
        options = "caps:escape,grp:win_space_toggle";
        repeat_rate = 40;
        repeat_delay = 250;
      };

      touchpad = {
        tap = true;
        natural_scroll = true;
        disable_while_typing = true;
      };

      cursor = {
        theme = "Adwaita";
        size = 24;
      };

      focus = {
        follows_mouse = true;
        follows_mouse_max_scroll = 0.0;
      };
    };

    layout = {
      mode = "scrolling";
      gap = 10;
      extent_presets = [
        0.333
        0.5
        0.667
      ];

      scrolling = {
        default_extent_fraction = 0.5;
        center_focused = "never";
      };
    };

    animation.enabled = false;

    overview.zoom = 0.75;

    hot_corners = {
      top_left.enabled = false;
      top_right.enabled = false;
      bottom_left.enabled = false;
      bottom_right.enabled = false;
    };

    keybinds = {
      # Applications and session
      "Mod+Return" = "spawn:foot";
      "Mod+D" = "spawn:noctalia msg panel-open launcher";
      "Mod+S" = "spawn:noctalia msg panel-toggle session";
      "Mod+Shift+C" = "spawn:hyprpicker -a";
      "Mod+P" = "spawn:launch-terminal password-picker";
      "Mod+B" = "spawn:noctalia msg bar-toggle";
      "Super+Alt+L" = "spawn:noctalia msg session lock";

      "XF86MonBrightnessUp" = {
        action = "spawn:noctalia msg brightness-up";
        allow_when_locked = true;
      };
      "XF86MonBrightnessDown" = {
        action = "spawn:noctalia msg brightness-down";
        allow_when_locked = true;
      };
      "XF86AudioRaiseVolume" = {
        action = "spawn:noctalia msg volume-up 1";
        allow_when_locked = true;
      };
      "XF86AudioLowerVolume" = {
        action = "spawn:noctalia msg volume-down 1";
        allow_when_locked = true;
      };
      "XF86AudioMute" = {
        action = "spawn:noctalia msg volume-mute";
        allow_when_locked = true;
      };
      "XF86AudioMicMute" = {
        action = "spawn:noctalia msg mic-mute";
        allow_when_locked = true;
      };
      "XF86AudioPlay" = {
        action = "spawn:noctalia msg media play";
        allow_when_locked = true;
      };
      "XF86AudioPause" = {
        action = "spawn:noctalia msg media pause";
        allow_when_locked = true;
      };
      "XF86AudioNext" = {
        action = "spawn:noctalia msg media next";
        allow_when_locked = true;
      };
      "XF86AudioPrev" = {
        action = "spawn:noctalia msg media previous";
        allow_when_locked = true;
      };

      "Mod+O" = {
        action = "overview-toggle";
        repeat = false;
      };

      "Mod+Shift+Q" = "window-close";

      # Focus navigation
      "Mod+Left" = "window-focus-left";
      "Mod+Down" = "window-focus-down";
      "Mod+Up" = "window-focus-up";
      "Mod+Right" = "window-focus-right";
      "Mod+H" = "window-focus-left";
      "Mod+J" = "window-focus-down";
      "Mod+K" = "window-focus-up";
      "Mod+L" = "window-focus-right";

      # Move windows/columns
      "Mod+Ctrl+Left" = "column-move-left";
      "Mod+Ctrl+Down" = "window-move-down";
      "Mod+Ctrl+Up" = "window-move-up";
      "Mod+Ctrl+Right" = "column-move-right";
      "Mod+Ctrl+H" = "column-move-left";
      "Mod+Ctrl+J" = "window-move-down";
      "Mod+Ctrl+K" = "window-move-up";
      "Mod+Ctrl+L" = "column-move-right";

      "Mod+Home" = "column-focus-first";
      "Mod+End" = "column-focus-last";
      "Mod+Ctrl+Home" = "column-move-to-first";
      "Mod+Ctrl+End" = "column-move-to-last";

      # Workspaces
      "Mod+Page_Down" = "workspace-next";
      "Mod+Page_Up" = "workspace-previous";
      "Mod+I" = "workspace-next";
      "Mod+U" = "workspace-previous";
      "Mod+Ctrl+Page_Down" = "window-move-to-workspace-next";
      "Mod+Ctrl+Page_Up" = "window-move-to-workspace-previous";
      "Mod+Ctrl+U" = "window-move-to-workspace-previous";
      "Mod+Ctrl+I" = "window-move-to-workspace-next";

      "Mod+WheelDown" = "workspace-next";
      "Mod+WheelUp" = "workspace-previous";

      "Mod+1" = "workspace-switch:1";
      "Mod+2" = "workspace-switch:2";
      "Mod+3" = "workspace-switch:3";
      "Mod+4" = "workspace-switch:4";
      "Mod+5" = "workspace-switch:5";
      "Mod+6" = "workspace-switch:6";
      "Mod+7" = "workspace-switch:7";
      "Mod+8" = "workspace-switch:8";
      "Mod+9" = "workspace-switch:9";

      "Mod+Shift+1" = "window-move-to-workspace:1";
      "Mod+Shift+2" = "window-move-to-workspace:2";
      "Mod+Shift+3" = "window-move-to-workspace:3";
      "Mod+Shift+4" = "window-move-to-workspace:4";
      "Mod+Shift+5" = "window-move-to-workspace:5";
      "Mod+Shift+6" = "window-move-to-workspace:6";
      "Mod+Shift+7" = "window-move-to-workspace:7";
      "Mod+Shift+8" = "window-move-to-workspace:8";
      "Mod+Shift+9" = "window-move-to-workspace:9";

      "Mod+Tab" = "workspace-next";
      "Mod+Shift+Tab" = "workspace-previous";

      # Consume/expel
      "Mod+Comma" = "window-consume-left";
      "Mod+Period" = "window-consume-right";

      # Sizing
      "Mod+R" = "window-cycle-primary-extent";
      "Mod+Shift+R" = "window-cycle-primary-extent-back";
      "Mod+F" = "window-toggle-fullscreen";
      "Mod+Ctrl+F" = "window-toggle-maximize";
      "Mod+C" = "column-center";

      "Mod+Minus" = "window-modify-primary-extent:-0.1";
      "Mod+Equal" = "window-modify-primary-extent:0.1";
      "Mod+Shift+Minus" = "window-modify-secondary-extent:-0.1";
      "Mod+Shift+Equal" = "window-modify-secondary-extent:0.1";

      # Floating
      "Mod+V" = "window-toggle-floating";
      "Mod+Shift+V" = "window-focus-switch-floating";

      "Mod+Escape" = {
        action = "shortcuts-inhibit-toggle";
        allow_when_inhibited = true;
      };

      "Mod+Shift+P" = "session-quit";
      "Mod+Shift+E" = "session-quit";
    };

    window_rule = [
      {
        match.app_id = "^(nm-connection-editor|password-picker|pavucontrol)$";
        default_floating = true;
        default_floating_size_px = {
          width = 1280;
          height = 720;
        };
      }
      {
        match.app_id = "^dev.noctalia.Noctalia$";
        default_floating = true;
        default_floating_size_px = {
          width = 1080;
          height = 920;
        };
      }
    ];

    layer_rule = [
      {
        match.namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd|desktop-widget-[^\"]*)$";
        blur = true;
        blur_ignore_alpha = 0.5;
        blur_popups = true;
        blur_optimized = false;
      }
    ];

    include.optional.files = [ "theme.toml" ];
  };

  mkTheme = variant: {
    colors = {
      inherit (variant) background;
      text_primary = variant.foreground;
      text_muted = variant.bright-black;
      accent_primary = variant.blue;
      accent_secondary = variant.purple;
      warning = variant.yellow;
      error = variant.red;
    };

    colors.border = {
      focused = variant.blue;
      unfocused = variant.bright-black;
    };

    colors.overview.background_tint = variant.overview;
  };
in
{
  options.programs.umbriel = {
    enable = lib.mkEnableOption "the Umbriel wayland compositor.";

    package = lib.mkPackageOption pkgs "umbriel" { };

    settings = lib.mkOption {
      inherit (toml) type;
      default = { };
      description = "Umbriel configuration, expressed as Nix attrs and converted to TOML.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];

    programs.umbriel.settings = defaultSettings;

    xdg.config.files = {
      "umbriel/config.toml".source = toml.generate "config.toml" cfg.settings;

      "umbriel/theme.toml".variants = {
        dark = {
          text = builtins.readFile (toml.generate "theme.toml" (mkTheme config.colors.dark));
          default = config.colorscheme.default == "dark";
        };

        light = {
          text = builtins.readFile (toml.generate "theme.toml" (mkTheme config.colors.light));
          default = config.colorscheme.default == "light";
        };
      };
    };
  };
}
