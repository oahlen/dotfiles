{ ... }:
{
  imports = [
    ./colors/default.nix

    ./desktops/niri.nix

    ./features/development
    ./features/gaming.nix
    ./features/standalone.nix

    ./programs/bash
    ./programs/bat
    ./programs/bottom
    ./programs/fish
    ./programs/gitui
    ./programs/ideavim
    ./programs/neovim
    ./programs/niri
    ./programs/tmux
    ./programs/wlr-which-key
    ./programs/yazi

    ./programs/direnv.nix
    ./programs/fd.nix
    ./programs/foot.nix
    ./programs/fuzzel.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/jq.nix
    ./programs/mako.nix
    ./programs/ripgrep.nix
    ./programs/waybar.nix
    ./programs/zoxide.nix

    ./services/flatpak.nix

    ./mimeapps.nix
    ./settings.nix
  ];
}
