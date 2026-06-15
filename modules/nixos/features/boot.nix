{
  config,
  lib,
  ...
}:
let
  cfg = config.features.boot;
in
{
  options.features.boot.enable = lib.mkEnableOption "boot settings.";

  config = lib.mkIf cfg.enable {
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
  };
}
