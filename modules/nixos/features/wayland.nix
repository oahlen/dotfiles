{
  config,
  lib,
  ...
}:
let
  cfg = config.features.wayland;
in
{
  options.features.wayland.enable = lib.mkEnableOption "Wayland related settings.";

  config = lib.mkIf cfg.enable {
    environment.sessionVariables = {
      _JAVA_AWT_WM_NONREPARENTING = "1";
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      SDL_VIDEODRIVER = "wayland";
    };
  };
}
