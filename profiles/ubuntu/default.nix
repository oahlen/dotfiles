{ pkgs, ... }:
{
  modules.direnv.enable = true;

  environment.packages = with pkgs; [
    brightnessctl
    customPackages.foot
    customPackages.niri
    fastfetch
    fuzzel
    # swaylock Use locker directly from Ubuntu
    hyprpicker
    mako
    playerctl
    soteria
    swaybg
    swayidle
    swayosd
    waybar
    wl-clipboard
    wlr-which-key
    wlsunset
    xwayland-satellite
  ];
}
