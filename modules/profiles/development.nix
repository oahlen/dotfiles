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
    modules.packages.enable = true;

    environment = {
      systemPackages = [
        pkgs.direnv
        pkgs.nix-direnv
      ];

      pathsToLink = [ "/share/nix-direnv" ];
    };
  };
}
