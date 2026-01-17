{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.niri;
  shared = import ./../shared/desktop.nix { inherit pkgs; };
in
{
  options.modules.niri.enable = mkEnableOption "Whether to enable the Niri window manager.";

  config = mkIf cfg.enable {
    inherit (shared) boot fonts;

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
      swayosd.enable = true;

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

      waybar = {
        enable = true;
        extraPackages = with pkgs; [
          hyprpicker
          pavucontrol
          wl-clipboard
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
    }
    // shared.services;

    environment = {
      systemPackages = with pkgs; [
        adwaita-icon-theme
        adw-gtk3
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
        pavucontrol
        playerctl
        swaybg
        wf-recorder
        wl-clipboard
        wl-mirror
        xdg-utils
        xwayland-satellite
      ];
    }
    // shared.environment;
  };
}
