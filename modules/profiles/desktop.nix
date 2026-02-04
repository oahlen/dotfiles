{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.desktop;
in
{
  options.modules.desktop.enable = mkEnableOption "Whether to enable desktop related features.";

  config = mkIf cfg.enable {
    boot = {
      loader.systemd-boot.enable = true;

      plymouth.enable = true;

      consoleLogLevel = 3;
      initrd.verbose = false;
      initrd.systemd.enable = true;

      kernelParams = [
        "quiet"
        "splash"
        "intremap=on"
        "boot.shell_on_fail"
        "udev.log_priority=3"
        "rd.systemd.show_status=auto"
      ];
    };

    fonts.packages = with pkgs; [
      dejavu_fonts
      liberation_ttf
      nerd-fonts.jetbrains-mono
      noto-fonts-color-emoji
    ];

    modules = {
      yubikey.enable = true;
    };

    services = {
      flatpak.enable = true;
      fstrim.enable = true;

      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      power-profiles-daemon.enable = true;

      tailscale = {
        enable = true;
        useRoutingFeatures = "both";
      };
    };

    programs = {
      firefox.enable = true; # Default browser
    };

    environment.sessionVariables = {
      _JAVA_AWT_WM_NONREPARENTING = "1";
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      SDL_VIDEODRIVER = "wayland";
    };

    environment.systemPackages = with pkgs; [
      fastfetch
      nfs-utils
    ];

    fileSystems."/".options = [
      "noatime"
      "nodiratime"
      "discard"
    ];
  };
}
