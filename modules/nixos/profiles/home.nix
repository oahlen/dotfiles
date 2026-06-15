{
  config,
  lib,
  ...
}:
let
  cfg = config.profiles.home;
in
{
  options.profiles.home.enable = lib.mkEnableOption "home profile.";

  config = lib.mkIf cfg.enable {
    features = {
      yubikey.enable = true;
    };

    services.tailscale = {
      enable = true;
      useRoutingFeatures = "both";
    };
  };
}
