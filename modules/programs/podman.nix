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
  options.modules.podman = {
    enable = lib.mkEnableOption "Whether to enable Podman.";
    dockerCompat = lib.mkEnableOption "Whether to enable docker related compatibility features.";
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

    # Add user to podman group in order to connect with the docker socket
    users.users.${config.user.name}.extraGroups = if cfg.dockerCompat then [ "podman" ] else [ ];

    environment.systemPackages = [ pkgs.podman-compose ];
  };
}
