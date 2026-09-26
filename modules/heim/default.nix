{ ... }:
{
  imports = [
    ./features/agentic.nix
    ./features/cli.nix
    ./features/development.nix
    ./features/gaming.nix
    ./features/window-manager.nix

    ./options/colors

    ./profiles/default.nix
    ./profiles/standalone.nix
    ./profiles/wsl.nix

    ./programs/ideavim
    ./programs/niri
    ./programs/noctalia
    ./programs/scripts
    ./programs/tmux
    ./programs/vscode

    ./programs/bash.nix
    ./programs/bat.nix
    ./programs/bottom.nix
    ./programs/direnv.nix
    ./programs/fd.nix
    ./programs/fish.nix
    ./programs/foot.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/gitui.nix
    ./programs/goose.nix
    ./programs/neovim.nix
    ./programs/rbw.nix
    ./programs/ripgrep.nix
    ./programs/rtk.nix
    ./programs/windows-terminal.nix
    ./programs/yazi.nix
    ./programs/zoxide.nix

    ./mimeapps.nix
    ./settings.nix
  ];
}
