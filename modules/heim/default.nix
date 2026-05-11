{ ... }:
{
  imports = [
    ./colors/default.nix

    ./desktops/niri.nix

    ./features/development.nix
    ./features/gaming.nix

    ./programs/niri
    ./programs/wlr-which-key

    ./programs/direnv.nix
    ./programs/foot.nix
    ./programs/fuzzel.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/jq.nix
    ./programs/mako.nix
    ./programs/ripgrep.nix
    ./programs/waybar.nix

    ./services/flatpak.nix

    ./options.nix
    ./settings.nix
  ];
}
