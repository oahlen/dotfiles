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
  options.modules.development.enable = lib.mkEnableOption "basic development features.";

  config = lib.mkIf cfg.enable {
    environment = {
      packages = with pkgs; [
        customPackages.environment
        direnv
        nix-direnv
      ];

      pathsToLink = [ "/share/nix-direnv" ];
    };
  };
}
