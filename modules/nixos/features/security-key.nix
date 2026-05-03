{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.security-key;
in
{
  options.features.security-key.enable = lib.mkEnableOption "security key support.";

  config = lib.mkIf cfg.enable {
    services.pcscd.enable = true;

    services.udev.packages = [ pkgs.yubikey-personalization ];

    programs.yubikey-touch-detector.enable = true;

    environment.systemPackages = [ pkgs.yubioath-flutter ];
  };
}
