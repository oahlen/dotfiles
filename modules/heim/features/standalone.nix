{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.standalone;
in
{
  options.features.standalone.enable = lib.mkEnableOption "standalone (generic) linux support.";

  config = lib.mkIf cfg.enable {
    home.sessionVariables = {
      NIX_PATH = lib.mkForce "nixpkgs=${builtins.storePath pkgs.path}";
    };
  };
}
