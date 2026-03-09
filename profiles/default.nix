{ module, pkgs }:
let
  defaultPackages = import ../shared/packages.nix { inherit pkgs; };
  config = import module { inherit pkgs; };
in
pkgs.callPackage ./builder.nix {
  packages = defaultPackages ++ config.packages;
  inherit (config) enableDirenv;
}
