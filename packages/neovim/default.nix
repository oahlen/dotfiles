{
  neovim-unwrapped,
  sources,
  vimPlugins,
  vimUtils,
  wrapNeovimUnstable,
}:
let
  agentic-nvim = vimUtils.buildVimPlugin {
    inherit (sources.agentic-nvim)
      pname
      version
      src
      ;
    doCheck = false;
  };

  aurora-nvim = vimUtils.buildVimPlugin {
    inherit (sources.aurora-nvim)
      pname
      version
      src
      ;
  };

  shellcheck-nvim = vimUtils.buildVimPlugin {
    inherit (sources.shellcheck-nvim)
      pname
      version
      src
      ;
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
  plugins = with vimPlugins; [
    agentic-nvim
    aurora-nvim
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
    shellcheck-nvim
    treesitter
    which-key-nvim
  ];
  wrapRc = false; # Use ~/.config/nvim/init.lua
}
