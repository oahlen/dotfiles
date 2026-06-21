{
  pkgs,
  ...
}:
{
  profiles = {
    default.enable = true;
  };

  features = {
    development.enable = true;
    niri.enable = true;
  };

  programs = {
    niri = {
      extraConfig = ''
        output "eDP-1" {
            scale 2.0
        }

        spawn-at-startup "${pkgs.swaybg}/bin/swaybg" "-o" "*" "-i" "/home/oahlen/Pictures/Wallpapers/sunset.jpg" "-m" "fit"
      '';
    };
  };

  services.flatpak.packages = [
    "com.github.PintaProject.Pinta"
    "com.onepassword.OnePassword"
    "md.obsidian.Obsidian"
    "org.chromium.Chromium"
    "org.inkscape.Inkscape"
  ];

  home = {
    files = {
      "Pictures/Wallpapers".source = ./Wallpapers;
    };

    packages = with pkgs; [
      customPackages.rbw
      fastfetch
    ];
  };
}
