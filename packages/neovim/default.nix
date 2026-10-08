{
  neovim-unwrapped,
  sources,
  vimPlugins,
  vimUtils,
  wrapNeovimUnstable,
  ...
}:
let
  buildPlugin =
    source:
    vimUtils.buildVimPlugin {
      inherit (source) pname version src;
      doCheck = false;
    };

  plugins = map (plugin: {
    plugin = (vimPlugins.${plugin.nix} or (buildPlugin sources.${plugin.nix})) // {
      pname = plugin.name; # Set correct plugin name for lz.n and packadd
    };
    optional = !(plugin.start or false);
  }) (builtins.fromJSON (builtins.readFile ./config/plugins.json));

  treesitter = vimPlugins.nvim-treesitter.withPlugins (
    parsers: map (name: parsers.${name}) (builtins.fromJSON (builtins.readFile ./config/parsers.json))
  );

  configPlugin = vimUtils.buildVimPlugin {
    pname = "config";
    version = "1.0.0";
    src = ./config;
    doCheck = false;
  };
in
wrapNeovimUnstable neovim-unwrapped {
  plugins = plugins ++ [
    treesitter
    configPlugin
  ];

  wrapRc = false;
}
