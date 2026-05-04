{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.waybar;
in
{
  options.programs.waybar.enable = lib.mkEnableOption "waybar.";

  config = lib.mkIf cfg.enable {
    packages = [ pkgs.waybar ];

    xdg.config.files =
      let
        base = [
          {
            position = "top";
            layer = "top";
            height = 40;
            spacing = 20;
            modules-left = [ "niri/workspaces" ];
            modules-center = [ "clock" ];
            modules-right = [
              "niri/language"
              "network"
              "battery"
              "wireplumber"
            ];

            "niri/workspaces" = {
              "disable-scroll" = true;
            };

            clock = {
              format = "{:%d %B %H:%M}";
              tooltip = false;
            };

            "niri/language" = {
              format = "{short}";
            };

            tray = {
              spacing = 16;
            };

            network = {
              format-icons = [
                "󰤯 "
                "󰤟 "
                "󰤢 "
                "󰤥 "
                "󰤨 "
              ];
              format = "{icon}";
              format-wifi = "{icon}";
              format-ethernet = "󰀂 ";
              format-disconnected = "󰤮 ";
              tooltip-format-wifi = "{essid} ({frequency} GHz)";
              tooltip-format-ethernet = "Connected";
              tooltip-format-disconnected = "Disconnected";
              interval = 3;
              spacing = 1;
            };

            battery = {
              format = "{icon}";
              format-full = "󰂅";
              format-icons = {
                charging = [
                  "󰢜"
                  "󰂆"
                  "󰂇"
                  "󰂈"
                  "󰢝"
                  "󰂉"
                  "󰢞"
                  "󰂊"
                  "󰂋"
                  "󰂅"
                ];
                default = [
                  "󰁺"
                  "󰁻"
                  "󰁼"
                  "󰁽"
                  "󰁾"
                  "󰁿"
                  "󰂀"
                  "󰂁"
                  "󰂂"
                  "󰁹"
                ];
              };
              format-plugged = "";
              interval = 15;
              states = {
                critical = 15;
                warning = 30;
              };
              tooltip-format-charging = "Capacity: {capacity}%\nTime: {time}\nCharging at: {power:>1.0f}W\nHealth: {health}%";
              tooltip-format-discharging = "Capacity: {capacity}%\nTime: {time}\nDischarging at {power:>1.0f}W\nHealth: {health}%";
            };

            wireplumber = {
              format = "{icon}";
              format-icons = {
                default = [
                  " "
                  " "
                  " "
                ];
              };
              format-muted = " ";
              on-click = "${pkgs.swayosd}/bin/swayosd-client --output-volume mute-toggle";
              on-scroll-up = "${pkgs.swayosd}/bin/swayosd-client --output-volume +1";
              on-scroll-down = "${pkgs.swayosd}/bin/swayosd-client --output-volume -1";
              tooltip-format = "Playing at {volume}%";
            };
          }
        ];

        mkStyle = variant: ''
          @define-color bg ${variant.background};
          @define-color fg ${variant.bright-white};
          @define-color fg_dim ${variant.bright-black};
          @define-color accent ${variant.blue};
          @define-color green ${variant.green};
          @define-color highlight ${variant.selection.highlight};
          @define-color red ${variant.red};
          @define-color cyan ${variant.cyan};

          * {
              font-family: "JetBrainsMono Nerd Font";
              font-size: 15px;
          }

          window#waybar {
              background: transparent;
          }

          window > box {
              margin: 8px 8px 0px 8px;
              background: @bg;
              color: @fg;
              border-radius: 8px;
          }

          #workspaces {
              padding: 4px;
          }

          #workspaces button {
              color: @fg;
              padding: 0px 6px;
              margin: 0 2px;
              border: none;
              border-radius: 8px;
              transition: none;
          }

          #workspaces button.empty {
              color: @fg_dim;
          }

          #workspaces button:hover {
              background: @fg;
              color: @bg;
              box-shadow: inherit;
              text-shadow: inherit;
          }

          #workspaces button.focused {
              background: @accent;
              color: @bg;
              font-weight: bold;
          }

          #workspaces button.focused:hover {
              background: @fg;
              box-shadow: inherit;
              text-shadow: inherit;
          }

          #clock {
              font-weight: bold;
          }

          #language,
          #network,
          #battery,
          #wireplumber {
              color: @fg;
          }

          #language {
              font-weight: bold;
              padding: 0 4px;
          }

          #battery,
          #network,
          #wireplumber {
              font-size: 17px;
          }

          #battery.charging,
          #battery.plugged {
              color: @green;
          }

          #battery.warning {
              color: @highlight;
          }

          #battery.critical {
              color: @red;
          }

          #wireplumber {
              margin-right: 8px;
          }

          tooltip {
              background: @bg;
              border: 2px solid @cyan;
              border-radius: 8px;
          }

          tooltip label {
              color: @fg;
          }
        '';
      in
      {
        "waybar/config".text = lib.generators.toJSON { } base;
        "waybar/style-dark.css".text = mkStyle config.colors.dark;
        "waybar/style-light.css".text = mkStyle config.colors.light;
      };
  };
}
