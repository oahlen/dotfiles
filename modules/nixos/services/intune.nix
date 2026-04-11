{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.intune;
in
{
  options.modules.intune.enable = lib.mkEnableOption "Microsoft Intune.";

  config = lib.mkIf cfg.enable {
    services.intune.enable = true;

    # Update /etc/os-release values to make Intune happy
    system.nixos = {
      distroId = "ubuntu";

      extraOSReleaseArgs = {
        VERSION_ID = "24.04";
      };
    };
  };
}
