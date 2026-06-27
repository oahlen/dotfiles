{
  config,
  lib,
  ...
}:
let
  cfg = config.mimeapps;

  attrsOfDesktopEntries = lib.types.attrsOf lib.types.str;
in
{
  options.mimeapps = {
    added = lib.mkOption {
      type = attrsOfDesktopEntries;
      default = { };
      description = "MIME type to desktop file mappings for Added Associations.";
    };

    default = lib.mkOption {
      type = attrsOfDesktopEntries;
      default = { };
      description = "MIME type to desktop file mappings for Default Applications.";
    };

    removed = lib.mkOption {
      type = attrsOfDesktopEntries;
      default = { };
      description = "MIME type to desktop file mappings for Removed Associations.";
    };
  };

  config = lib.mkIf (cfg.added != { } || cfg.default != { } || cfg.removed != { }) {
    xdg.config.files = {
      "mimeapps.list".text = lib.generators.toINI { } {
        "Added Associations" = cfg.added;
        "Default Applications" = cfg.default;
        "Removed Associations" = cfg.removed;
      };
    };
  };
}
