{
  pkgs,
  pkgs-unstable,
  sources,
}:
let
  entries = builtins.readDir ./.;
  dirs = builtins.filter (name: entries.${name} == "directory") (builtins.attrNames entries);
  mkAttr = name: {
    inherit name;
    value = pkgs.callPackage ./${name} { inherit pkgs-unstable sources; };
  };
in
builtins.listToAttrs (map mkAttr dirs)
