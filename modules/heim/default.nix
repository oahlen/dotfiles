{ ... }:
{
  imports = [
    ./features/cli.nix
    ./features/development.nix
    ./features/gaming.nix
    ./features/gnome.nix
    ./features/niri.nix

    ./options/colors

    ./profiles/default.nix
    ./profiles/standalone.nix
    ./profiles/work.nix
    ./profiles/wsl.nix

    ./programs/copilot
    ./programs/fish
    ./programs/ideavim
    ./programs/neovim
    ./programs/niri
    ./programs/tmux
    ./programs/wlr-which-key

    ./programs/bash.nix
    ./programs/firefox.nix
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
    ./programs/mako.nix
    ./programs/one-password.nix
    ./programs/rbw.nix
    ./programs/ripgrep.nix
    ./programs/waybar.nix
    ./programs/windows-terminal.nix
    ./programs/yazi.nix
    ./programs/zoxide.nix

    ./services/flatpak.nix

    ./mimeapps.nix
    ./settings.nix
  ];
}
