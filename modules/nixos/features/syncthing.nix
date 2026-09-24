{
  config,
  lib,
  ...
}:
let
  cfg = config.features.syncthing;
  home = "/home/${config.defaultUser.name}";
in
{
  options.features.syncthing.enable = lib.mkEnableOption "Syncthing file sync.";

  config = lib.mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      user = config.defaultUser.name;
      dataDir = home;
      configDir = "${home}/.config/syncthing";
      openDefaultPorts = true;

      settings = {
        devices.server = {
          id = "UJEXY4P-ZSFTBKZ-WMEDBYR-4YXEBIX-VY3OLSH-U2WCKFB-QFKM3LW-KOZRRQE";
        };

        folders."${home}/Documents/Notes" = {
          id = "Notes";
          devices = [ "server" ];
        };
      };
    };
  };
}
