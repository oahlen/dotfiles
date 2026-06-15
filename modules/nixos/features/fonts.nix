{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.fonts;
in
{
  options.features.fonts.enable = lib.mkEnableOption "system fonts.";

  config = lib.mkIf cfg.enable {
    fonts.packages = with pkgs; [
      dejavu_fonts
      liberation_ttf
      nerd-fonts.jetbrains-mono
      noto-fonts-color-emoji
    ];
  };
}
