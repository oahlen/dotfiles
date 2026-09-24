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

  packages = with pkgs; [
    git
    jq
    just
    nix
    nixfmt-tree
    npins
    statix
    stylua
  ];
}
