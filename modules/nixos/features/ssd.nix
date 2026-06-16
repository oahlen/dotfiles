{
  config,
  lib,
  ...
}:
let
  cfg = config.features.ssd;
in
{
  options.features.ssd.enable = lib.mkEnableOption "SSD storage configuration.";

  config = lib.mkIf cfg.enable {
    services.fstrim.enable = true;

    fileSystems."/".options = [
      "noatime"
      "nodiratime"
    ];
  };
}
