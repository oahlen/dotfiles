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
    boot.kernelPackages = pkgs.linuxPackages_zen; # Gaming kernel

    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true; # Required by some more modern games like The Witcher 3
      };

      uinput.enable = true; # Virtual gamepad support
    };

    # Group for reading CPU power monitoring
    users.groups.rapl = {
      members = config.primaryUsers;
    };

    services = {
      # Enable overclocking
      lact.enable = true;

      udev = {
        # Add udev rules for common game controllers
        packages = [ pkgs.game-devices-udev-rules ];

        # Allow the rapl group to read CPU energy counters
        extraRules = ''
          ACTION=="add|change", SUBSYSTEM=="powercap", KERNEL=="intel-rapl:*", \
            RUN+="${pkgs.coreutils}/bin/chgrp rapl /sys/%p/energy_uj", \
            RUN+="${pkgs.coreutils}/bin/chmod g+r /sys/%p/energy_uj"
        '';
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

    users.groups.gamemode.members = config.primaryUsers;
  };
}
