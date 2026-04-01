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

  options.modules.niri.enable = lib.mkEnableOption "Whether to enable the Niri window manager.";

  config = lib.mkIf cfg.enable {
    environment = {
      packages = with pkgs; [
        brightnessctl
        customPackages.foot
        customPackages.niri
        fastfetch
        fuzzel
        hyprpicker
        mako
        playerctl
        soteria
        swaybg
        swayidle
        # swaylock Use locker directly from distribution
        swayosd
        waybar
        wl-clipboard
        wlr-which-key
        wlsunset
        xwayland-satellite
      ];

      pathsToLink = [
        "/share/applications"
        "/share/icons"
      ];
    };
  };
}
