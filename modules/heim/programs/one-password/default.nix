{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.one-password;
in
{
  options.programs.one-password.enable = lib.mkEnableOption "1password.";

  config = lib.mkIf cfg.enable {
    home = {
      files = {
        ".local/bin/op-password-picker".source = ./op-password-picker;
      };

      packages = [ pkgs._1password-cli ];
    };

    services.flatpak.packages = [ "com.onepassword.OnePassword" ];
  };
}
