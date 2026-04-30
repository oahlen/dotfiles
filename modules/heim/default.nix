{ ... }:
{
  imports = [
    ./features/development.nix
    ./features/gaming.nix
    ./features/niri.nix

    ./programs/niri
    ./programs/waybar
    ./programs/foot.nix
    ./programs/fuzzel.nix
    ./programs/mako.nix
    ./programs/wlr-which-key.nix
  ];

  # These settings are not applied when running as a nixos module
  pathsToLink = [
    "/bin"
    "/share/doc"
    "/share/man"
  ];

  extraOutputsToInstall = [
    "man"
    "doc"
  ];

  overwrite = true;
}
