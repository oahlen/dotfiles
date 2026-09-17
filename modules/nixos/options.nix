{
  config,
  lib,
  ...
}:
{
  options = {
    primaryUsers = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "Primary interactive users of this host, derived from `users.users.<name>.isNormalUser`.";
    };

    wayland.systemd.target = lib.mkOption {
      type = lib.types.str;
      default = "graphical-session.target";
      description = "The systemd user target for Wayland compositor session (e.g., sway-session.target).";
    };
  };

  config = {
    primaryUsers = lib.mkDefault (
      lib.attrNames (lib.filterAttrs (_: u: u.isNormalUser) config.users.users)
    );
  };
}
