{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.window-manager;
in
{
  options.features.window-manager.enable = lib.mkEnableOption "the preferred window manager and related desktop components.";

  config = lib.mkIf cfg.enable {
    wayland.systemd.target = "niri-session.target";

    programs = {
      niri.enable = true;
    };

    systemd.user.targets.niri-session = {
      description = "niri compositor session";
      documentation = [ "man:systemd.special(7)" ];
      bindsTo = [ "graphical-session.target" ];
      wants = [ "graphical-session-pre.target" ];
      after = [ "graphical-session-pre.target" ];
    };

    users.groups =
      let
        users = config.users.groups.users.members;
      in
      {
        audio.members = users;
        networkmanager.members = users;
        video.members = users;
      };

    services = {
      displayManager = {
        gdm.enable = true;
        defaultSession = lib.mkDefault "niri";
      };

      dbus.enable = true;
      noctalia.enable = true;
    };

    environment.systemPackages = with pkgs; [
      adwaita-icon-theme
      libnotify
      pavucontrol
    ];
  };
}
