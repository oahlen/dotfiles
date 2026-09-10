{
  config,
  lib,
  pkgs-unstable,
  ...
}:
let
  cfg = config.programs.rtk;
in
{
  options.programs.rtk.enable = lib.mkEnableOption "rtk, a CLI proxy to filter and summarize command output for LLM contexts.";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs-unstable.rtk ];

    features.agentic.stickyPromptLines = [
      "Always prefix shell commands with `rtk` (e.g. `rtk git status`, `rtk cargo test`, `rtk npm run build`) to compress command output before it reaches context."
    ];
  };
}
