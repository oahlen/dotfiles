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
    "niri/config.kdl".source = ./config/niri/config.kdl;
    "scripts/flatpak-sync".source = ./config/scripts/flatpak-sync;
  };
}
