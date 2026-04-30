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

    extraPackages = lib.mkOption {
      type = with lib.types; listOf package;
      default = [ ];
      description = "Extra packages to be installed alonside Niri.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      foot.enable = true;
      fuzzel.enable = true;
      mako.enable = true;
      niri.enable = true;
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
      ++ cfg.extraPackages;

    pathsToLink = [
      "/share/applications"
      "/share/icons"
    ];
  };
}
