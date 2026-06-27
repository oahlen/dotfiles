{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.profiles.default;
in
{
  options.profiles.default.enable = lib.mkEnableOption "the default profile.";

  config = lib.mkIf cfg.enable {
    features = {
      cli.enable = true;
    };

    programs = {
      firefox.enable = true;
    };

    mimeapps.default = {
      "image/jpeg" = "org.gnome.Loupe.desktop";
      "image/png" = "org.gnome.Loupe.desktop";
      "inode/directory" = "org.gnome.Nautilus.desktop";
      "text/plain" = "org.gnome.TextEditor.desktop";
    };

    home = {
      packages = with pkgs; [
        fastfetch
      ];
    };
  };
}
