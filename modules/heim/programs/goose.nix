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
    features.agentic.stickyPromptLines = [
      "You are running in a nono sandbox, some commands or file paths might not be available."
    ];

    home = {
      packages = [ pkgs.customPackages.goose-cli ];

      files = {
        ".config/goose/.goosehints".text =
          lib.concatStringsSep "\n" config.features.agentic.stickyPromptLines;
      };
    };
  };
}
