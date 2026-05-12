{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.ripgrep;

  ripgreprc = lib.concatLines [
    "--glob"
    "!.cache/"
    "--glob"
    "!.git/"
  ];
in
{
  options.programs.ripgrep.enable = lib.mkEnableOption "ripgrep.";

  config = lib.mkIf cfg.enable {
    home = {
      packages = [ pkgs.ripgrep ];

      sessionVariables.RIPGREP_CONFIG_PATH = "$HOME/.config/ripgrep/ripgreprc";
    };

    xdg.config.files = {
      "ripgrep/ripgreprc".text = ripgreprc;
    };
  };
}
