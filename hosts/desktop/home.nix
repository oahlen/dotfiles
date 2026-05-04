{ pkgs, ... }:
let
  homeDirectory = "/home/oahlen";
in
{
  desktops.niri.enable = true;

  features = {
    development.enable = true;
    gaming.enable = true;
  };

  programs.niri.extraConfig = ''
    output "DP-2" {
        variable-refresh-rate on-demand=true
    }

    spawn-at-startup "systemctl" "--user" "start" "niri-session.target"

    spawn-at-startup "${pkgs.swaybg}/bin/swaybg" "-o" "*" "-i" "${homeDirectory}/Pictures/Wallpapers/buck.jpg" "-m" "fit"
  '';

  home = {
    directory = homeDirectory;

    files = {
      "Pictures/Wallpapers".source = ./config/Wallpapers;
    };
  };

  xdg.config.files = {
    "scripts/flatpak-sync".source = ./config/scripts/flatpak-sync;
  };

  packages = with pkgs; [
    customPackages.hytale-launcher
    customPackages.rbw
    fastfetch
    filen-cli
  ];

  colorscheme.name = "tokyonight";
}
