{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.copilot;
in
{
  options.programs.copilot.enable = lib.mkEnableOption "GitHub Copilot.";

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        customPackages.copilot
        rtk
      ];

      files = {
        ".copilot/" = {
          source = ./config;
          recursive = true;
        };
      };
    };
  };
}
