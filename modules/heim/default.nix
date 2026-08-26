{ ... }:
{
  imports = [
    ./features/cli.nix
    ./features/desktop-environment.nix
    ./features/development.nix
    ./features/gaming.nix
    ./features/window-manager.nix

    ./options/colors

    ./profiles/default.nix
    ./profiles/standalone.nix
    ./profiles/work.nix
    ./profiles/wsl.nix

    ./programs/fish
    ./programs/ideavim
    ./programs/neovim
    ./programs/niri
    ./programs/noctalia
    ./programs/tmux

    ./programs/bash.nix
    ./programs/bat.nix
    ./programs/bottom.nix
    ./programs/direnv.nix
    ./programs/fd.nix
    ./programs/foot.nix
    ./programs/fuzzel.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/gitui.nix
    ./programs/jq.nix
    ./programs/one-password.nix
    ./programs/rbw.nix
    ./programs/ripgrep.nix
    ./programs/windows-terminal.nix
    ./programs/yazi.nix
    ./programs/zoxide.nix

    ./mimeapps.nix
    ./settings.nix
  ];
}
