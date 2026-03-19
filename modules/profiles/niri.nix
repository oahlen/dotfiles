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
  options.modules.niri.enable = lib.mkEnableOption "Whether to enable the Niri window manager.";

  config = lib.mkIf cfg.enable {
    wayland.systemd.target = "niri-session.target";

    programs = {
      dconf.enable = true;
      gnome-disks.enable = true;

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
      nm-applet.enable = true;
    };

    systemd.user.targets.niri-session = {
      description = "niri compositor session";
      documentation = [ "man:systemd.special(7)" ];
      bindsTo = [ "graphical-session.target" ];
      wants = [ "graphical-session-pre.target" ];
      after = [ "graphical-session-pre.target" ];
    };

    users.users.${config.user.name}.extraGroups = [
      "audio"
      "video"
    ];

    networking.networkmanager.enable = true;

    security.rtkit.enable = true;

    modules = {
      polkit-soteria.enable = true;
      swaybg.enable = true;

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

    services = {
      blueman.enable = config.hardware.bluetooth.enable;
      displayManager.gdm.enable = true;

      dbus = {
        enable = true;
        packages = [
          pkgs.gcr_4
          pkgs.mako
        ];
      };

      gvfs.enable = true;
      tumbler.enable = true;
    };

    environment.systemPackages = with pkgs; [
      adwaita-icon-theme
      adw-gtk3
      bluetui
      brightnessctl
      foot
      fuzzel
      gnome-multi-writer
      gnome-text-editor
      hyprpicker
      libnotify
      loupe
      mako
      nautilus
      papirus-icon-theme
      playerctl
      wf-recorder
      wiremix
      wl-clipboard
      wl-mirror
      wlr-which-key
      xdg-utils
      xwayland-satellite
    ];
  };
}
