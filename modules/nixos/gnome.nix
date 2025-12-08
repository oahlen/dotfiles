{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.gnome;
  shared = import ./../shared/desktop.nix { inherit pkgs; };
in
{
  options.modules.gnome.enable = mkEnableOption "Whether to enable the Gnome desktop environment.";

  config = mkIf cfg.enable {
    inherit (shared) boot fonts;

    services = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;

      gnome = {
        evolution-data-server.enable = mkForce false;
        gnome-online-accounts.enable = false;
      };
    }
    // shared.services;

    environment = {
      systemPackages =
        with pkgs;
        [
          dconf-editor
          gnome-tweaks
          papirus-icon-theme
        ]
        ++ (with pkgs.gnomeExtensions; [
          color-picker
          gnome-40-ui-improvements
          places-status-indicator
        ]);

      gnome.excludePackages = with pkgs; [
        baobab
        cheese
        epiphany
        evince
        file-roller
        geary
        gedit
        gnome-backgrounds
        gnome-calendar
        gnome-clocks
        gnome-connections
        gnome-contacts
        gnome-logs
        gnome-maps
        gnome-music
        gnome-software
        gnome-tour
        gnome-user-docs
        gnome-weather
        orca
        seahorse
        simple-scan
        totem
        yelp
      ];
    }
    // shared.environment;

    programs.evolution.enable = false;
  };
}
