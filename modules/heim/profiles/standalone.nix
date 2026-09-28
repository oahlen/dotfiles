{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.profiles.standalone;

  nix-config = pkgs.customPackages.nix-config;
in
{
  options.profiles.standalone.enable = lib.mkEnableOption "standalone (generic) linux profile.";

  config = lib.mkIf cfg.enable {
    features = {
      cli.enable = true;
    };

    home = {
      packages = [ nix-config.package ];

      sessionVariables = {
        NIX_PATH = lib.mkForce "nixpkgs=${builtins.storePath pkgs.path}";
      };
    };

    activationHooks = [ nix-config.activation ];
  };
}
