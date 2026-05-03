{
  config,
  lib,
  ...
}:
let
  cfg = config.profiles.work;
in
{
  options.profiles.work.enable = lib.mkEnableOption "work profile.";

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
