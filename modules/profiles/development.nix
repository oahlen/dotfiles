{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.development;
in
{
  options.modules.development.enable = lib.mkEnableOption "Whether to enable basic development features.";

  config = lib.mkIf cfg.enable {
    environment.packages = import ../shared/packages.nix { inherit pkgs; };
  };
}
