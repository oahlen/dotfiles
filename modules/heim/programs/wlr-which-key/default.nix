{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.wlr-which-key;

  switch-theme = pkgs.callPackage ./switch-theme.nix {
    inherit (config.colorscheme) default;
  };

  base = {
    font = "JetBrainsMono Nerd Font 11.5";
    separator = " ➜ ";
    border_width = 2;
    corner_r = 8;
    padding = 24;
    rows_per_column = 10;
    column_padding = 24;

    anchor = "center";

    inhibit_compositor_keyboard_shortcuts = true;

    auto_kbd_layout = true;

    menu = [
      {
        key = "o";
        desc = "Output Settings";
        submenu = [
          {
            key = "1";
            desc = "Set Resolution to 1920x1200";
            cmd = ''
              niri msg output eDP-1 custom-mode 1920x1200@60
              niri msg output eDP-1 scale 1
              notify-send "Monitor" "Resolution set 1920x1200\nScaling set to 1.0"
            '';
          }
          {
            key = "2";
            desc = "Set Resolution to 3840x2400";
            cmd = ''
              niri msg output eDP-1 mode 3840x2400@60
              niri msg output eDP-1 scale 2
              notify-send "Monitor" "Resolution set 3840x2400\nScaling set to 2.0"
            '';
          }
        ];
      }
      {
        key = "p";
        desc = "Power Profiles";
        submenu = [
          {
            key = "b";
            desc = "Balanced";
            cmd = ''
              powerprofilesctl set balanced
              notify-send "Power Profile" "Set to Balanced"
            '';
          }
          {
            key = "p";
            desc = "Performance";
            cmd = ''
              powerprofilesctl set performance
              notify-send "Power Profile" "Set to Performance"
            '';
          }
          {
            key = "s";
            desc = "Saver";
            cmd = ''
              powerprofilesctl set power-saver
              notify-send "Power Profile" "Set to Power saver"
            '';
          }
        ];
      }
      {
        key = "s";
        desc = "System Actions";
        submenu = [
          {
            key = "s";
            desc = "Suspend";
            cmd = "systemctl suspend";
          }
          {
            key = "r";
            desc = "Reboot";
            cmd = "systemctl reboot";
          }
          {
            key = "p";
            desc = "Poweroff";
            cmd = "systemctl poweroff";
          }
        ];
      }
      {
        key = "w";
        desc = "Workspace profiles";
        submenu = [
          {
            key = "w";
            desc = "Work";
            cmd = ''
              heim-activate --variant work
              notify-send "Workspace Mode" "Switched to Work mode"
            '';
          }
          {
            key = "v";
            desc = "Vibe";
            cmd = ''
              heim-activate --variant vibe
              notify-send "Workspace Mode" "Switched to Vibe mode"
            '';
          }
        ];
      }
      {
        key = "t";
        desc = "Theme Settings";
        submenu = [
          {
            key = "t";
            desc = "Default";
            cmd = "switch-theme default";
          }
          {
            key = "d";
            desc = "Dark";
            cmd = "switch-theme dark";
          }
          {
            key = "l";
            desc = "Light";
            cmd = "switch-theme light";
          }
        ];
      }
    ];
  };

  mkColors = variant: {
    inherit (variant) background;
    color = variant.foreground;
    border = variant.cyan;
  };
in
{
  options.programs.wlr-which-key.enable = lib.mkEnableOption "wlr-which-key.";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      wlr-which-key
      switch-theme
    ];

    xdg.config.files = {
      "wlr-which-key/config.yaml".variants = {
        dark = {
          text = lib.generators.toYAML { } (base // mkColors config.colors.dark);
          default = config.colorscheme.default == "dark";
        };

        light = {
          text = lib.generators.toYAML { } (base // mkColors config.colors.light);
          default = config.colorscheme.default == "light";
        };
      };
    };
  };
}
