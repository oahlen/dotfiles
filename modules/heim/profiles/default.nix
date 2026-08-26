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

    mimeapps.default = {
      "application/pdf" = "chromium";
      "application/x-extension-htm" = "chromium";
      "application/x-extension-html" = "chromium";
      "application/x-extension-shtml" = "chromium";
      "application/x-extension-xht" = "chromium";
      "application/x-extension-xhtml" = "chromium";
      "application/xhtml+xml" = "chromium";
      "image/jpeg" = "org.gnome.Loupe.desktop";
      "image/png" = "org.gnome.Loupe.desktop";
      "inode/directory" = "org.gnome.Nautilus.desktop";
      "text/html" = "chromium";
      "text/plain" = "org.gnome.TextEditor.desktop";
      "x-scheme-handler/chrome" = "chromium";
      "x-scheme-handler/http" = "chromium";
      "x-scheme-handler/https" = "chromium";
    };

    home = {
      files = {
        "Pictures/Wallpapers" = {
          source = ./wallpapers;
          recursive = true;
          keepOutOfStore = true;
        };
      };

      packages = with pkgs; [
        fastfetch
      ];
    };
  };
}
