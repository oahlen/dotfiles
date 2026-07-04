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
      gtklock = {
        enable = true;

        config = {
          main = {
            gtk-theme = "adw-gtk3-dark";
            idle-hide = true;
            idle-timeout = 10;
          };
        };

        modules = with pkgs; [
          gtklock-playerctl-module
          gtklock-powerbar-module
          gtklock-userinfo-module
        ];
      };

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

      blueman.enable = config.hardware.bluetooth.enable;

      dbus = {
        enable = true;
        packages = [
          pkgs.gcr_4
          pkgs.mako
        ];
      };

      polkit-soteria.enable = true;

      swayidle = {
        enable = true;

        events = [
          {
            event = "before-sleep";
            command = "${pkgs.gtklock}/bin/gtklock -d";
          }
        ];

        timeouts = [
          {
            timeout = 300;
            command = "${pkgs.gtklock}/bin/gtklock -d";
          }
          {
            timeout = 900;
            command = "${lib.getExe pkgs.niri} msg action power-off-monitors";
            resumeCommand = "${lib.getExe pkgs.niri} msg action power-on-monitors";
          }
          {
            timeout = 1800;
            command = "${pkgs.systemd}/bin/systemctl suspend";
          }
        ];
      };

      swayosd.enable = true;

      waybar = {
        enable = true;
        extraPackages = [
          pkgs.bash # We might run scripts through waybar
          pkgs.swayosd
        ];
      };

      wlsunset = {
        enable = true;
        args = [
          "-L"
          "17.64"
          "-l"
          "59.85"
          "-T"
          "6500"
          "-t"
          "4500"
        ];
      };
    };

    environment.systemPackages = with pkgs; [
      adwaita-icon-theme
      libnotify
      mako
      pavucontrol
    ];
  };
}
