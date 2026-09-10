{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.goose;
in
{
  options.programs.goose.enable = lib.mkEnableOption "goose, an AI coding agent CLI.";

  config = lib.mkIf cfg.enable {
    home = {
      packages = [ pkgs.customPackages.goose-cli ];

      files = {
        ".config/goose/.goosehints".text =
          lib.concatStringsSep "\n" config.features.agentic.stickyPromptLines;
      };
    };
  };
}
