{ ... }:
{
  imports = [
    ./features/cli.nix
    ./features/dotnet.nix
    ./features/nix-dev.nix
    ./features/rust.nix
    ./features/standalone.nix

    ./options/colors

    ./profiles/desktops/niri.nix
    ./profiles/development
    ./profiles/gaming.nix

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
