{
  config,
  lib,
  ...
}:
{
  options = {
    defaultUser = {
      name = lib.mkOption {
        type = lib.types.str;
        description = "The name of the primary user of this host.";
      };

      description = lib.mkOption {
        type = lib.types.str;
        description = "The description of the primary user of this host.";
      };
    };

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
    users.users.${config.defaultUser.name} = {
      inherit (config.defaultUser) description;
      isNormalUser = true;
      uid = lib.mkDefault 1000;
      extraGroups = [ "wheel" ];
    };

    primaryUsers = lib.mkDefault (
      lib.attrNames (lib.filterAttrs (_: u: u.isNormalUser) config.users.users)
    );
  };
}
