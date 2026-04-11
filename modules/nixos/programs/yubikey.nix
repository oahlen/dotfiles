{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.yubikey;
in
{
  options.modules.yubikey.enable = lib.mkEnableOption "Yubikey support.";

  config = lib.mkIf cfg.enable {
    services.pcscd.enable = true;

    services.udev.packages = [ pkgs.yubikey-personalization ];

    programs.yubikey-touch-detector.enable = true;

    environment.systemPackages = [ pkgs.yubioath-flutter ];
  };
}
