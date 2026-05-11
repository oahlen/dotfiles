{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.bat;
in
{
  options.programs.bat.enable = lib.mkEnableOption "bat.";

  config = lib.mkIf cfg.enable {
    packages = with pkgs; [
      bat
      bat-extras.batman
    ];

    xdg.config.files = {
      "bat/config".text = ''
        --theme=base16
      '';

      "bat/themes".source = ./themes;
    };
  };
}
