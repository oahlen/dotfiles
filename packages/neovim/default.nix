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

  plugins =
    (with vimPlugins; [
      blink-cmp
      fzf-lua
      gitsigns-nvim
      heirline-nvim
      indent-blankline-nvim
      nvim-autopairs
      nvim-colorizer-lua
      nvim-lspconfig
      nvim-tree-lua
      nvim-web-devicons
      render-markdown-nvim
      which-key-nvim
    ])
    ++ map (name: buildPlugin sources.${name}) [
      "agentic-nvim"
      "aurora-nvim"
      "shellcheck-nvim"
    ];

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

  luaRcContent = "vim.g.nix = true";
}
