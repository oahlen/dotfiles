{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.niri;
in
{
  options.modules.niri = {
    enable = lib.mkEnableOption "the Niri window manager.";

    standalone = {
      enable = lib.mkEnableOption "standalone package options for non NixOS setups.";

      packages = lib.mkOption {
        type = with lib.types; listOf package;
        default = with pkgs; [
          customPackages.niri
          mako
          soteria
          swayidle
          swayosd
          waybar
          wlsunset
        ];
        description = "Default packages for standalone Niri installation.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      foot.enable = true;
      fuzzel.enable = true;
      mako.enable = true;
      wlr-which-key.enable = true;
    };
    packages =
      with pkgs;
      [
        brightnessctl
        hyprpicker
        playerctl
        swaybg
        wf-recorder
        wl-clipboard
        wl-mirror
        xwayland-satellite
      ]
      ++ (if cfg.standalone.enable then cfg.standalone.packages else [ ]);

    pathsToLink = [
      "/share/applications"
      "/share/icons"
    ];

    xdg.config.files = {
      "MangoHud".source = ./config/MangoHud;
      "niri".source = ./config/niri;
      "swaylock".source = ./config/swaylock;
      "waybar".source = ./config/waybar;
    };
  };
}
