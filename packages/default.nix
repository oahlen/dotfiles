{ pkgs }:
let
  entries = builtins.readDir ./.;
  dirs = builtins.filter (name: entries.${name} == "directory") (builtins.attrNames entries);
  mkAttr = name: {
    inherit name;
    value = pkgs.callPackage ./${name} {
      sources = pkgs.callPackage ../sources/generated.nix { };
    };
  };
in
builtins.listToAttrs (map mkAttr dirs)
