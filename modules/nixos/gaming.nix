{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.gaming;
in
{
  options.modules.gaming = {
    enable = mkEnableOption "Whether to enable gaming support.";
  };

  config = mkIf cfg.enable {
    hardware = {
      amdgpu.overdrive.enable = true;

      graphics = {
        enable = true;
        enable32Bit = true; # Required by some more modern games like The Witcher 3
      };

      uinput.enable = true; # Virtual gamepad support
    };

    services.lact.enable = true;

    # Add udev rules for common game controllers
    services.udev.packages = [ pkgs.game-devices-udev-rules ];

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

    users.users.${config.user.name}.extraGroups = [ "gamemode" ];

    # Game launchers and utilities
    environment.systemPackages = [
      pkgs.heroic
      pkgs.mangohud
    ];
  };
}
