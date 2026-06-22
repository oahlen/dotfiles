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
    gaming.enable = true;
    niri.enable = true;
  };

  programs = {
    niri.extraConfig = ''
      output "DP-2" {
          variable-refresh-rate on-demand=true
      }

      spawn-at-startup "${pkgs.swaybg}/bin/swaybg" "-o" "*" "-i" "/home/oahlen/Pictures/Wallpapers/buck.jpg" "-m" "fit"
    '';

    rbw.enable = true;
  };

  services.flatpak = {
    enable = true;
    packages = [
      "com.bitwarden.desktop"
      "com.github.PintaProject.Pinta"
      "io.github.ungoogled_software.ungoogled_chromium"
      "md.obsidian.Obsidian"
      "org.inkscape.Inkscape"
      "org.keepassxc.KeePassXC"
    ];
  };

  home = {
    files = {
      "Pictures/Wallpapers".source = ./Wallpapers;
    };

    packages = with pkgs; [
      customPackages.hytale-launcher
      filen-cli
    ];
  };
}
