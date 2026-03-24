{ pkgs }:
{
  enableDirenv = true;

  packages = with pkgs; [
    brightnessctl
    customPackages.foot
    customPackages.niri
    fastfetch
    fuzzel
    hyprpicker
    mako
    playerctl
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
