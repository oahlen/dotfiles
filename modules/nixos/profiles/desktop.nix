{
  config,
  lib,
  ...
}:
let
  cfg = config.profiles.desktop;
in
{
  options.profiles.desktop.enable = lib.mkEnableOption "desktop profile.";

  config = lib.mkIf cfg.enable {
    features = {
      audio.enable = true;
      boot.enable = true;
      core-apps.enable = true;
      fonts.enable = true;
      storage.enable = true;
      wayland.enable = true;
    };

    services = {
      flatpak.enable = true;
      power-profiles-daemon.enable = true;
    };
  };
}
