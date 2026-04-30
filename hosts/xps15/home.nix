{ pkgs, ... }:
{
  modules = {
    development.enable = true;

    niri = {
      enable = true;
      extraPackages = with pkgs; [
        soteria
        swayidle
        swayosd
        wlsunset
      ];
    };
  };

  programs = {
    niri = {
      package = pkgs.customPackages.niri;
      extraConfig = ''
        output "eDP-1" {
            scale 2.0
        }

        binds {
            Super+Alt+L hotkey-overlay-title="Lock the Screen" { spawn "swaylock"; }
        }

        spawn-sh-at-startup "swaybg -o \"*\" -i ~/Pictures/Wallpapers/sunset.jpg -m fit"

        spawn-sh-at-startup "waybar"

        spawn-sh-at-startup "polkit-soteria"

        spawn-sh-at-startup "swayosd-server"

        spawn-sh-at-startup "wlsunset -L 17.64 -l 59.85 -T 6500 -t 4500"

        spawn-sh-at-startup "mako"

        spawn-sh-at-startup "swayidle -w timeout 300 'swaylock -f' timeout 900 'niri msg action power-off-monitors' resume 'niri msg action power-on-monitors' timeout 1800 'systemctl suspend' before-sleep 'swaylock -f'"
      '';
    };

    swaylock = {
      enable = true;
      package = null;
    };
  };

  home = {
    directory = "/home/oahlen";

    files = {
      "Pictures/Wallpapers".source = ./config/Wallpapers;
    };
  };

  xdg.config.files = {
    "environment.d".source = ./config/environment.d;
    "scripts/apply-conf".source = ./config/scripts/apply-conf;
    "scripts/flatpak-sync".source = ./config/scripts/flatpak-sync;
  };

  packages = [ pkgs.fastfetch ];
}
