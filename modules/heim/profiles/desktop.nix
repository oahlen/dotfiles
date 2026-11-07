{
  config,
  lib,
  ...
}:
let
  cfg = config.profiles.desktop;
in
{
  options.profiles.desktop.enable = lib.mkEnableOption "the desktop profile.";

  config = lib.mkIf cfg.enable {
    features = {
      cli.enable = true;
    };

    mimeapps.default = {
      "application/pdf" = "firefox";
      "application/x-extension-htm" = "firefox";
      "application/x-extension-html" = "firefox";
      "application/x-extension-shtml" = "firefox";
      "application/x-extension-xht" = "firefox";
      "application/x-extension-xhtml" = "firefox";
      "application/xhtml+xml" = "firefox";
      "image/jpeg" = "org.gnome.Loupe.desktop";
      "image/png" = "org.gnome.Loupe.desktop";
      "inode/directory" = "org.gnome.Nautilus.desktop";
      "text/html" = "firefox";
      "text/plain" = "org.gnome.TextEditor.desktop";
      "x-scheme-handler/chrome" = "firefox";
      "x-scheme-handler/http" = "firefox";
      "x-scheme-handler/https" = "firefox";
    };

    home = {
      files = {
        "Pictures/Wallpapers" = {
          source = ./wallpapers;
          recursive = true;
          keepOutOfStore = true;
        };
      };
    };
  };
}
