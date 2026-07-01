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
    features = {
      chromium.blockThirdPartyCookies = false;

      gnome.enable = true;
    };

    services.intune.enable = true;

    # Update /etc/os-release values to make Intune happy
    system.nixos = {
      distroId = "ubuntu";

      extraOSReleaseArgs = {
        VERSION_ID = "26.04";
      };
    };
  };
}
