{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) concatStringsSep;

  cfg = config.programs.fzf;

  defaultCommand = concatStringsSep " " [
    "fd"
    "--type f"
    "--hidden"
    "--follow"
  ];

  colors = concatStringsSep "," [
    "bg+:0"
    "border:7"
    "fg+:15"
    "gutter:0"
    "header:4"
    "hl:3"
    "hl+:3"
    "info:8"
    "marker:6"
    "pointer:3"
    "prompt:2"
    "scrollbar:8"
    "separator:8"
    "spinner:5"
  ];

  flags = concatStringsSep " " [
    "--layout=reverse"
    "--height=40%"
    "--scrollbar '▌'"
    "--color ${colors}"
  ];
in
{
  options.programs.fzf.enable = lib.mkEnableOption "fzf.";

  config = lib.mkIf cfg.enable {
    home = {
      packages = [ pkgs.fzf ];

      sessionVariables = {
        FZF_DEFAULT_COMMAND = defaultCommand;
        FZF_DEFAULT_OPTS = flags;
        _ZO_FZF_OPTS = (lib.mkIf config.programs.zoxide.enable) flags;
      };
    };
  };
}
