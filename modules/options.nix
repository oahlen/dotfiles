{ lib, ... }:
{
  options = {
    user = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "oahlen";
        description = "The name of the primary user.";
      };

      fullName = lib.mkOption {
        type = lib.types.str;
        default = "Oscar Ahlén";
        description = "The full name of the primary user.";
      };
    };

    wayland.systemd.target = lib.mkOption {
      type = lib.types.str;
      default = "graphical-session.target";
      description = "The systemd user target for Wayland compositor session (e.g., sway-session.target).";
    };
  };
}
