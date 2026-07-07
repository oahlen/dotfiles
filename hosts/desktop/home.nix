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

  home = {
    files = {
      "Pictures/Wallpapers" = {
        source = ./Wallpapers;
        recursive = true;
      };
    };

    packages = with pkgs; [
      customPackages.hytale-launcher
      customPackages.logseq
      filen-cli
      keepassxc
      pinta
      spotify
    ];
  };
}
