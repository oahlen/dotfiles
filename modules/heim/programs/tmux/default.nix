{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.tmux;
in
{
  options.programs.tmux.enable = lib.mkEnableOption "tmux.";

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        tmux
        tmuxp
      ];

      sessionVariables.TMUXP_PROGRESS = 0;
    };

    xdg.config.files = {
      "tmux/tmux.conf".source = ./tmux.conf;
      "tmuxp".source = ./tmuxp;
    };
  };
}
