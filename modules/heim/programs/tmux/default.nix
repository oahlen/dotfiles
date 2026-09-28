{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.tmux;

  deps = with pkgs; [
    tmux
    tmuxp
  ];

  dev-session = pkgs.writeShellApplication {
    name = "dev-session";

    runtimeInputs = deps;

    text = ''
      dir=$(fd --type d | fzf)

      if [ -z "$dir" ] || [ ! -d "$dir" ]; then
          exit 0
      fi

      export TMUX_DIR="$dir"

      name=$(basename "$dir" | tr '.' '-')
      export TMUX_SESSION=$name

      tmuxp load -y dev-session -s "$TMUX_SESSION"
    '';
  };
in
{
  options.programs.tmux.enable = lib.mkEnableOption "tmux.";

  config = lib.mkIf cfg.enable {
    home = {
      packages = deps ++ [
        dev-session
      ];

      sessionVariables.TMUXP_PROGRESS = 0;
    };

    xdg.config.files = {
      "tmux/tmux.conf".source = ./tmux.conf;
      "tmuxp" = {
        source = ./tmuxp;
        recursive = true;
      };
    };
  };
}
