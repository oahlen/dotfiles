{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.tailscale;
in
{
  options.modules.tailscale = {
    enable = mkEnableOption "Whether to enable tailscale.";
  };

  config = mkIf cfg.enable {
    services.tailscale = {
      enable = true;
      useRoutingFeatures = "both";
    };
  };
}
