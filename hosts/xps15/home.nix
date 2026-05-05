{ pkgs, ... }:
{
  desktops.niri = {
    enable = true;
    extraPackages = with pkgs; [
      soteria
      swayidle
      swayosd
      wlsunset
    ];
  };

  features = {
    development.enable = true;
  };

  programs = {
    niri = {
      package = pkgs.customPackages.niri;
      extraConfig = ''
        output "eDP-1" {
            scale 2.0
        }

        spawn-sh-at-startup "swaybg -o \"*\" -i ~/Pictures/Wallpapers/sunset.jpg -m fit"

        spawn-sh-at-startup "waybar"

        spawn-sh-at-startup "polkit-soteria"

        spawn-sh-at-startup "swayosd-server"

        spawn-sh-at-startup "wlsunset -L 17.64 -l 59.85 -T 6500 -t 4500"

        spawn-sh-at-startup "mako"

        spawn-sh-at-startup "swayidle -w timeout 300 'gtklock -d' timeout 900 'niri msg action power-off-monitors' resume 'niri msg action power-on-monitors' timeout 1800 'systemctl suspend' before-sleep 'gtklock -d'"
      '';
    };
  };

  services.flatpak.packages = [
    "com.github.PintaProject.Pinta"
    "md.obsidian.Obsidian"
    "org.chromium.Chromium"
    "org.inkscape.Inkscape"
  ];

  home = {
    directory = "/home/oahlen";

    files = {
      "Pictures/Wallpapers".source = ./Wallpapers;
    };
  };

  xdg.config.files = {
    "environment.d/30-nix.conf".text = ''
      [Lookup]
      PATH=%h/.local/state/nix/profile/bin
    '';

    "scripts/apply-conf".source = ./scripts/apply-conf;
  };

  packages = [ pkgs.fastfetch ];
}
