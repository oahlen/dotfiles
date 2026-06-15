{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.yubikey;
in
{
  options.features.yubikey.enable = lib.mkEnableOption "Yubikey support.";

  config = lib.mkIf cfg.enable {
    services.pcscd.enable = true;

    services.udev.packages = [ pkgs.yubikey-personalization ];

    programs.yubikey-touch-detector.enable = true;

    environment.systemPackages = [ pkgs.yubioath-flutter ];
  };
}
