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

      niri = {
        enable = true;
        package = if cfg.standalone.enable then pkgs.customPackages.niri else pkgs.niri;
      };

      waybar.enable = true;
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
  };
}
