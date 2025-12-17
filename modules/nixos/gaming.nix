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

    services = {
      # Enable overclocking
      lact.enable = true;

      # Add udev rules for common game controllers
      udev.packages = [ pkgs.game-devices-udev-rules ];

      # Fixes for audio crackling
      pipewire.extraConfig = {
        pipewire."99-custom-quantum.conf" = {
          "context.properties" = {
            "default.clock.min-quantum" = 1024;
            "default.clock.max-quantum" = 8192;
          };
        };
        pipewire-pulse."99-custom-quantum.conf" = {
          "context.properties" = {
            "pulse.min.quantum" = "1024/48000";
            "pulse.default.quantum" = "1024/48000";
            "pulse.max.quantum" = "8192/48000";
          };
        };
      };
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

    users.users.${config.user.name}.extraGroups = [ "gamemode" ];

    # Game launchers and utilities
    environment.systemPackages = [
      pkgs.heroic
      pkgs.mangohud
    ];
  };
}
