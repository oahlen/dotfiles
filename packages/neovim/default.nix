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

  buildPlugins = names: map (name: buildPlugin sources.${name}) names;

  customPlugins = buildPlugins [
    "agentic-nvim"
    "aurora-nvim"
    "shellcheck-nvim"
  ];

  configPlugin = vimUtils.buildVimPlugin {
    pname = "config";
    version = "1.0.0";
    src = ./config;
    doCheck = false;
  };

  treesitter = vimPlugins.nvim-treesitter.withPlugins (
    plugins: with plugins; [
      bash
      c
      comment
      c_sharp
      css
      desktop
      diff
      dockerfile
      editorconfig
      fish
      gitattributes
      gitcommit
      git_config
      gitignore
      git_rebase
      go
      html
      ini
      javascript
      json
      kdl
      just
      lua
      luadoc
      make
      markdown
      markdown_inline
      nix
      powershell
      properties
      proto
      python
      rust
      scss
      sql
      svelte
      tmux
      todotxt
      toml
      typescript
      typst
      vim
      vimdoc
      xml
      yaml
    ]
  );
in
wrapNeovimUnstable neovim-unwrapped {
  plugins =
    with vimPlugins;
    [
      blink-cmp
      conform-nvim
      fzf-lua
      gitsigns-nvim
      heirline-nvim
      indent-blankline-nvim
      lz-n
      nvim-autopairs
      nvim-colorizer-lua
      nvim-lspconfig
      nvim-tree-lua
      nvim-web-devicons
      render-markdown-nvim
      treesitter
      which-key-nvim
      configPlugin
    ]
    ++ customPlugins;

  wrapRc = false;
}
