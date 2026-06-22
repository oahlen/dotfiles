{ ... }:
{
  imports = [
    ./features/cli.nix
    ./features/development.nix
    ./features/gaming.nix
    ./features/niri.nix

    ./options/colors

    ./profiles/default.nix
    ./profiles/standalone.nix

    ./programs/fish
    ./programs/neovim
    ./programs/niri
    ./programs/tmux
    ./programs/wlr-which-key

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
    ./programs/ideavim.nix
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
