{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.wlr-which-key;

  mkColors = variant: {
    inherit (variant) background;
    color = variant.foreground;
    border = variant.cyan;
  };
in
{
  options.programs.wlr-which-key.enable = lib.mkEnableOption "wlr-which-key.";

  config = lib.mkIf cfg.enable {
    packages = [ pkgs.wlr-which-key ];

    xdg.config.files =
      let
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
              key = "m";
              desc = "Multimedia Controls";
              submenu = [
                {
                  key = "t";
                  desc = "Toggle Play/Pause";
                  cmd = "playerctl play-pause";
                }
                {
                  key = "n";
                  desc = "Next Track";
                  cmd = "playerctl next";
                }
                {
                  key = "p";
                  desc = "Previous Track";
                  cmd = "playerctl previous";
                }
              ];
            }
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
              desc = "System";
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
              key = "t";
              desc = "Theme Settings";
              submenu = [
                {
                  key = "t";
                  desc = "Default";
                  cmd = ''
                    dconf write /org/gnome/desktop/interface/color-scheme "'default'"
                    heim-activate --variant dark
                    pkill -USR2 foot || true
                    notify-send "Application Theme" "Set to Default"
                  '';
                }
                {
                  key = "d";
                  desc = "Dark";
                  cmd = ''
                    dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
                    heim-activate --variant dark
                    pkill -USR1 foot || true
                    notify-send "Application Theme" "Set to Dark"
                  '';
                }
                {
                  key = "l";
                  desc = "Light";
                  cmd = ''
                    dconf write /org/gnome/desktop/interface/color-scheme "'prefer-light'"
                    heim-activate --variant light
                    pkill -USR2 foot || true
                    notify-send "Application Theme" "Set to Light"
                  '';
                }
              ];
            }
          ];
        };
      in
      {
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
