{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.niri;
in
{
  options.features.niri.enable = lib.mkEnableOption "the Niri window manager and related desktop components.";

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

      dbus = {
        enable = true;
        packages = [ pkgs.gcr_4 ];
      };

      noctalia.enable = true;
    };

    environment.systemPackages = with pkgs; [
      adwaita-icon-theme
      libnotify
      pavucontrol
    ];
  };
}
