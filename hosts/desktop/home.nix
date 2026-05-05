{
  pkgs,
  ...
}:
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

  services.flatpak.packages = [
    "com.bitwarden.desktop"
    "com.github.PintaProject.Pinta"
    "io.github.ungoogled_software.ungoogled_chromium"
    "md.obsidian.Obsidian"
    "org.inkscape.Inkscape"
    "org.keepassxc.KeePassXC"
  ];

  home = {
    directory = homeDirectory;

    files = {
      "Pictures/Wallpapers".source = ./Wallpapers;
    };
  };

  packages = with pkgs; [
    customPackages.hytale-launcher
    customPackages.rbw
    fastfetch
    filen-cli
  ];

  colorscheme.name = "tokyonight";
}
