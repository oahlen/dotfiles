{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.gnome;

  extensions = with pkgs.gnomeExtensions; [
    color-picker
    gnome-40-ui-improvements
    places-status-indicator
  ];
in
{
  options.features.gnome.enable = lib.mkEnableOption "the Gnome desktop environment.";

  config = lib.mkIf cfg.enable {
    services = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;

      gnome = {
        core-apps.enable = lib.mkForce false; # Disables most basic apps
        evolution-data-server.enable = lib.mkForce false;
        gnome-online-accounts.enable = false;
      };
    };

    programs.evolution.enable = false;

    environment.systemPackages =
      with pkgs;
      [
        dconf-editor
        gnome-tweaks
      ]
      ++ extensions;
  };
}
