let
  sources = import ./npins;
  pkgs = import sources.nixpkgs {
    config = { };
    overlays = [ ];
  };
in
pkgs.mkShell {
  # Enable experimental features without having to specify the argument
  NIX_CONFIG = "experimental-features = nix-command flakes";
  NIX_SHELL = "Bootstrap";

  packages = with pkgs; [
    git
    just
    nix
    npins
  ];
}
