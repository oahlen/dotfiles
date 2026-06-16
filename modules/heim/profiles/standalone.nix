{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.profiles.standalone;
in
{
  options.profiles.standalone.enable = lib.mkEnableOption "standalone (generic) linux profile.";

  config = lib.mkIf cfg.enable {
    home.sessionVariables = {
      NIX_PATH = lib.mkForce "nixpkgs=${builtins.storePath pkgs.path}";
    };
  };
}
