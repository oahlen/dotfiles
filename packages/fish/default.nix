{
  fishPlugins,
  wrapFish,
  ...
}:
let
  configPlugin = fishPlugins.buildFishPlugin {
    pname = "config";
    version = "1.0.0";
    src = ./config;
  };
in
wrapFish {
  pluginPkgs = [ configPlugin ];
}
