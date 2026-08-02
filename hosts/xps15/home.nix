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
      pinta
    ];
  };
}
