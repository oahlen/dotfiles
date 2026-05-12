{
  lib,
  ...
}:
let
  added = { };

  default = {
    "application/pdf" = "firefox.desktop";
    "application/x-extension-htm" = "firefox.desktop";
    "application/x-extension-html" = "firefox.desktop";
    "application/x-extension-shtml" = "firefox.desktop";
    "application/x-extension-xht" = "firefox.desktop";
    "application/x-extension-xhtml" = "firefox.desktop";
    "application/xhtml+xml" = "firefox.desktop";
    "image/jpeg" = "org.gnome.Loupe.desktop";
    "image/png" = "org.gnome.Loupe.desktop";
    "inode/directory" = "org.gnome.Nautilus.desktop";
    "text/html" = "firefox.desktop";
    "text/plain" = "org.gnome.TextEditor.desktop";
    "x-scheme-handler/chrome" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
  };

  removed = { };
in
{
  xdg.config.files = {
    "mimeapps.list".text = lib.generators.toINI { } {
      "Added Associations" = added;
      "Default Applications" = default;
      "Removed Associations" = removed;
    };
  };
}
