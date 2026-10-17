{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}:
let
  cfg = config.programs.goose;
in
{
  options.programs.goose = {
    enable = lib.mkEnableOption "goose, an AI coding agent CLI.";
    desktop.enable = lib.mkEnableOption "goose desktop";
  };

  config = lib.mkIf cfg.enable {
    features.agentic.stickyPromptLines = [
      "You are running in a nono sandbox, some commands or file paths might not be available."
    ];

    home = {
      packages = [
        pkgs.customPackages.goose-cli
      ]
      ++ lib.optional cfg.desktop.enable pkgs-unstable.goose-desktop;

      files = {
        ".config/goose/.goosehints".text =
          lib.concatStringsSep "\n" config.features.agentic.stickyPromptLines;
      };
    };
  };
}
