{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.rbw;
in
{
  options.programs.rbw.enable = lib.mkEnableOption "rbw.";

  config = lib.mkIf cfg.enable {
    home = {
      files = {
        ".local/bin/password-picker".source = ./password-picker;
      };

      packages = [
        pkgs.customPackages.rbw
      ];
    };
  };
}
