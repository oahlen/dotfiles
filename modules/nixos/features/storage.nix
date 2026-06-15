{
  config,
  lib,
  ...
}:
let
  cfg = config.features.storage;
in
{
  options.features.storage.enable = lib.mkEnableOption "physical storage configuration.";

  config = lib.mkIf cfg.enable {
    services.fstrim.enable = true;

    fileSystems."/".options = [
      "noatime"
      "nodiratime"
    ];
  };
}
