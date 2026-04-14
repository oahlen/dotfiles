{ ... }:
{
  modules = {
    development.enable = true;
    niri.enable = true;
  };

  home = {
    directory = "/home/oahlen";
    overwrite = true;

    files = {
      "Pictures/Wallpapers".source = ./config/Wallpapers;
    };
  };

  xdg.config.files = {
    "environment.d".source = ./config/environment.d;
    "niri/config.kdl".source = ./config/niri/config.kdl;
    "scripts/apply-conf".source = ./config/scripts/apply-conf;
    "scripts/flatpak-sync".source = ./config/scripts/flatpak-sync;
  };
}
