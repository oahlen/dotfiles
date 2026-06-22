{
  config,
  lib,
  ...
}:
let
  cfg = config.features.gnome;
in
{
  options.features.gnome = {
    enable = lib.mkEnableOption "Gnome desktop tweaks.";
  };

  config = lib.mkIf cfg.enable {
    home.files = {
      # TODO Make into nix options
      ".local/bin/apply-gsettings".source = ./apply-gsettings;
    };
  };
}
