{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.containers;
in
{
  options.features.containers = {
    enable = lib.mkEnableOption "containers.";
    dockerCompat = lib.mkEnableOption "Docker related compatibility features.";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.podman = {
      enable = true;

      autoPrune = {
        enable = true;
        flags = [ "--all" ];
        dates = "weekly";
      };

      inherit (cfg) dockerCompat;
      dockerSocket.enable = cfg.dockerCompat;

      defaultNetwork.settings.dns_enabled = true;
    };

    environment.systemPackages = [ pkgs.podman-compose ];
  };
}
