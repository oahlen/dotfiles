{
  config,
  lib,
  pkgs-unstable,
  sources,
  ...
}:
let
  cfg = config.features.agentic;
in
{
  options.features.agentic = {
    enable = lib.mkEnableOption "agentic AI coding tools.";

    stickyPromptLines = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = ''
        Lines that should always be surfaced to AI coding agents
        (e.g. as sticky/persistent prompt instructions).
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      goose.enable = true;
      rtk.enable = true;
    };

    home = {
      files = {
        ".agents/skills".source = "${sources.agentic-skills.src}/skills";
      };

      packages = [
        pkgs-unstable.ccusage # TODO Use stable pkgs when upgrading to 26.11
      ];
    };
  };
}
