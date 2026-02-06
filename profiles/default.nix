{ module, pkgs }:
let
  defaultPackages = import ../shared/packages.nix { inherit pkgs; };
  packages = import ../packages { inherit pkgs; };
  config = import module { inherit pkgs packages; };
in
pkgs.callPackage ./builder.nix {
  packages = defaultPackages ++ config.packages;
  inherit (config) enableDirenv;
}
