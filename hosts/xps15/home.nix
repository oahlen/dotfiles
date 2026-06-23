{
  pkgs,
  ...
}:
{
  profiles = {
    default.enable = true;
    work.enable = true;
  };

  features = {
    development.enable = true;
    niri.enable = true;
  };

  programs = {
    niri.extraConfig = ''
      output "eDP-1" {
          scale 2.0
      }

      spawn-at-startup "${pkgs.swaybg}/bin/swaybg" "-o" "*" "-i" "/home/oahlen/Pictures/Wallpapers/sunset.jpg" "-m" "fit"
    '';

    rbw.enable = true;
  };

  services.flatpak = {
    enable = true;
    packages = [
      "com.github.PintaProject.Pinta"
      "md.obsidian.Obsidian"
      "org.chromium.Chromium"
      "org.inkscape.Inkscape"
    ];
  };

  home = {
    files = {
      "Pictures/Wallpapers" = {
        source = ./Wallpapers;
        recursive = true;
      };
    };
  };
}
