{ pkgs, ... }:
{
  modules = {
    development.enable = true;
    niri.enable = true;
  };

  programs = {
    mangohud.enable = true;
  };

  home = {
    directory = "/home/oahlen";

    files = {
      "Pictures/Wallpapers".source = ./config/Wallpapers;
    };
  };

  xdg.config.files = {
    "niri/config.kdl".source = ./config/niri/config.kdl;
    "scripts/flatpak-sync".source = ./config/scripts/flatpak-sync;
  };

  packages = with pkgs; [
    customPackages.hytale-launcher
    customPackages.rbw
    fastfetch
    filen-cli
  ];

  overwrite = true;
}
