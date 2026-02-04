{
  lib,
  pkgs,
  ...
}:
with lib;
{
  options = {
    user = {
      name = mkOption {
        type = lib.types.str;
        default = "oahlen";
        description = "The name of the primary user.";
      };

      fullName = mkOption {
        type = lib.types.str;
        default = "Oscar Ahlén";
        description = "The full name of the primary user.";
      };
    };

    packages = mkOption {
      type = types.attrsOf types.package;
      default = import ../packages { inherit pkgs; };
      description = "The available custom packages set.";
    };

    wayland.systemd.target = mkOption {
      type = lib.types.str;
      default = "graphical-session.target";
      description = "The systemd user target for Wayland compositor session (e.g., sway-session.target).";
    };
  };
}
