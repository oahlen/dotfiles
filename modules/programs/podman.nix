{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.podman;
in
{
  options.modules.podman.enable = lib.mkEnableOption "Whether to enable Podman.";

  config = lib.mkIf cfg.enable {
    virtualisation.podman = {
      enable = true;

      autoPrune = {
        enable = true;
        flags = [ "--all" ];
        dates = "weekly";
      };

      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    environment.systemPackages = [ pkgs.podman-compose ];
  };
}
