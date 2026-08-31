{
  config,
  lib,
  pkgs,
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
      chromium.enable = true;
      core-apps.enable = true;
      # firefox.enable = true;
      fonts.enable = true;
      ssd.enable = true;
      wayland.enable = true;
    };

    hardware.bluetooth.enable = true;

    networking.networkmanager.enable = true;

    services = {
      gvfs.enable = true;
      power-profiles-daemon.enable = true;
      tumbler.enable = true;
    };

    programs = {
      dconf.enable = true;
    };

    # Add hardcoded /bin/bash for compatibility reasons
    systemd.tmpfiles.rules = [
      "L+ /bin/bash - - - - ${pkgs.bashInteractive}/bin/bash"
    ];
  };
}
