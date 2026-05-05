{ ... }:
{
  imports = [
    ./colors/default.nix

    ./desktops/niri.nix

    ./features/development.nix
    ./features/gaming.nix

    ./programs/niri/default.nix
    ./programs/foot.nix
    ./programs/fuzzel.nix
    ./programs/mako.nix
    ./programs/waybar.nix
    ./programs/wlr-which-key.nix

    ./settings.nix
  ];
}
