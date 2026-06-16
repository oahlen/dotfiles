{ ... }:
{
  imports = [
    ./features/development
    ./features/scripts

    ./features/cli.nix
    ./features/gaming.nix
    ./features/niri.nix
    ./features/nix-dev.nix

    ./options/colors

    ./profiles/default.nix
    ./profiles/standalone.nix

    ./programs/bash
    ./programs/bat
    ./programs/fish
    ./programs/gitui
    ./programs/ideavim
    ./programs/neovim
    ./programs/niri
    ./programs/tmux
    ./programs/wlr-which-key

    ./programs/bottom.nix
    ./programs/direnv.nix
    ./programs/fd.nix
    ./programs/foot.nix
    ./programs/fuzzel.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/jq.nix
    ./programs/mako.nix
    ./programs/mangohud.nix
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
