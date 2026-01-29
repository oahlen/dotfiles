{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.desktop;
in
{
  options.modules.desktop.enable = mkEnableOption "Whether to enable desktop related features.";

  config = mkIf cfg.enable {
    boot.loader.systemd-boot.enable = true;

    modules = {
      tailscale.enable = true;
      yubikey.enable = true;
    };

    services = {
      flatpak.enable = true;
      fstrim.enable = true;
      power-profiles-daemon.enable = true;
    };

    programs.firefox.enable = true; # Default browser

    environment.systemPackages = with pkgs; [
      fastfetch
      nfs-utils
    ];

    fileSystems."/".options = [
      "noatime"
      "nodiratime"
      "discard"
    ];
  };
}
