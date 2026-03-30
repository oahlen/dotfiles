{ modules, pkgs }:
let
  evaluated = pkgs.lib.evalModules {
    specialArgs = { inherit pkgs; };
    modules = modules ++ ../modules/environment;
  };
in
pkgs.callPackage ./builder.nix {
  inherit (evaluated) config;
}
