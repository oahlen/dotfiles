{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.gaming;
in
{
  options.features.gaming = {
    enable = lib.mkEnableOption "gaming support.";
  };

  config = lib.mkIf cfg.enable {
    hardware = {
      amdgpu.overdrive.enable = true;

      graphics = {
        enable = true;
        enable32Bit = true; # Required by some more modern games like The Witcher 3
      };

      uinput.enable = true; # Virtual gamepad support
    };

    services = {
      # Enable overclocking
      lact.enable = true;

      # Add udev rules for common game controllers
      udev.packages = [ pkgs.game-devices-udev-rules ];
    };

    # Gamemode
    programs.gamemode = {
      enable = true;
      settings = {
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
        };
      };
    };

    users.groups.gamemode.members = config.users.groups.users.members;
  };
}
