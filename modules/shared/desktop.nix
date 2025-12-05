{ pkgs }:
{
  boot = {
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

  fonts = with pkgs; [
    dejavu_fonts
    liberation_ttf
    nerd-fonts.jetbrains-mono
    noto-fonts-color-emoji
  ];

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    SDL_VIDEODRIVER = "wayland";
  };
}
