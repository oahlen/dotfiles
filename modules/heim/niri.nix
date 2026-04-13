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
  options.modules.niri.enable = lib.mkEnableOption "the Niri window manager.";

  config = lib.mkIf cfg.enable {
    # home = {
    #   packages = with pkgs; [
    #     brightnessctl
    #     customPackages.foot
    #     customPackages.niri
    #     fastfetch
    #     fuzzel
    #     hyprpicker
    #     mako
    #     playerctl
    #     soteria
    #     swaybg
    #     swayidle
    #     # swaylock Use locker directly from distribution
    #     swayosd
    #     waybar
    #     wl-clipboard
    #     wlr-which-key
    #     wlsunset
    #     xwayland-satellite
    #   ];
    #
    #   pathsToLink = [
    #     "/share/applications"
    #     "/share/icons"
    #   ];
    # };

    xdg.config.files = {
      "foot".source = ../../config/foot;
      "fuzzel".source = ../../config/fuzzel;
      "mako".source = ../../config/mako;
      "MangoHud".source = ../../config/MangoHud;
      "niri".source = ../../config/niri;
      "swaylock".source = ../../config/swaylock;
      "waybar".source = ../../config/waybar;
      "wlr-which-key".source = ../../config/wlr-which-key;
    };
  };
}
