{ ... }:
{
  profiles = {
    standalone.enable = true;
  };

  programs = {
    ghostty = {
      enable = true;
      shell = "zsh";
    };

    tmux.enable = true;
    vscode.enable = true;
  };
}
