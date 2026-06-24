{
  config,
  lib,
  pkgs,
  sources,
  ...
}:
let
  cfg = config.programs.bat;
in
{
  options.programs.bat.enable = lib.mkEnableOption "bat.";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      bat
      bat-extras.batman
    ];

    xdg.config.files = {
      "bat/config".text = ''
        --theme=base16
      '';

      "bat/themes/base16.tmTheme".source = "${sources.base16-theme.src}/base16.tmTheme";
    };
  };
}
