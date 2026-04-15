{ pkgs, ... }:
{
  users.users.oahlen = {
    uid = 1000;
    description = "Oscar Ahlén";
    isNormalUser = true;
    extraGroups = [
      "audio"
      "gamemode"
      "video"
      "wheel"
    ];

    heim = {
      modules = {
        development.enable = true;
        niri.enable = true;
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
    };
  };
}
