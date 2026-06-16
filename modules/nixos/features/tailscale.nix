{
  config,
  lib,
  ...
}:
let
  cfg = config.features.tailscale;
in
{
  options.features.tailscale.enable = lib.mkEnableOption "Tailscale.";

  config = lib.mkIf cfg.enable {
    services.tailscale = {
      enable = true;
      useRoutingFeatures = "both";
    };
  };
}
