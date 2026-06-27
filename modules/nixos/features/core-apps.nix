{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.core-apps;
in
{
  options.features.core-apps.enable = lib.mkEnableOption "core system applications.";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      adw-gtk3
      gnome-multi-writer
      gnome-text-editor
      loupe
      nautilus
      papirus-icon-theme
      xdg-utils
    ];
  };
}
