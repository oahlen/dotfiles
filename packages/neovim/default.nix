{
  fetchFromGitHub,
  neovim-unwrapped,
  vimPlugins,
  vimUtils,
  wrapNeovimUnstable,
}:
let
  agentic-nvim = vimUtils.buildVimPlugin {
    pname = "agentic-nvim";
    version = "1.0.0";
    src = fetchFromGitHub {
      owner = "carlos-algms";
      repo = "agentic.nvim";
      rev = "57ec685e434d41c31df4b263dfb16b5b43dcfa48";
      sha256 = "sha256-CBvvByPvB6ST3nlT/0ozhIPZ8HabwGaRlXn33BGIlF0=";
    };

    meta.homepage = "https://github.com/carlos-algms/agentic.nvim";
    doCheck = false;
  };

  shellcheck-nvim = vimUtils.buildVimPlugin {
    pname = "shellcheck-nvim";
    version = "1.0.0";
    src = fetchFromGitHub {
      owner = "pablos123";
      repo = "shellcheck.nvim";
      rev = "ee40e705ea61a4d790907c93cd01cc52480351fa";
      sha256 = "sha256-1rfEtD+II1uh6cn/dBxwGKxNFUwgoKXWtcJHIi6ydy4=";
    };

    meta.homepage = "https://github.com/pablos123/shellcheck.nvim";
  };

  tokyonight-nvim = vimUtils.buildVimPlugin {
    pname = "tokyonight-nvim";
    version = "1.0.0";
    src = fetchFromGitHub {
      owner = "oahlen";
      repo = "tokyonight.nvim";
      rev = "40f882d1c051a95951c04d05a54830d85f1ef0cb";
      sha256 = "sha256-NomRKyrjIsyJMxLa38EXrmosgNlwxuhpv4vS8knf53Q=";
    };

    meta.homepage = "https://github.com/oahlen/tokyonight.nvim";
  };

  edge-nvim = vimUtils.buildVimPlugin {
    pname = "edge-nvim";
    version = "1.0.0";
    src = fetchFromGitHub {
      owner = "oahlen";
      repo = "edge.nvim";
      rev = "b3262820cb336cefe577e1b0ceb8836bc56f5510";
      sha256 = "sha256-OH6I8VpYVtdI3CxpXJxFkHkAksvE+BgOi+E1S0Aclbg=";
    };

    meta.homepage = "https://github.com/oahlen/edge.nvim";
  };

  treesitter = vimPlugins.nvim-treesitter.withPlugins (
    plugins: with plugins; [
      bash
      c
      comment
      c_sharp
      css
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
      java
      javascript
      json
      kdl
      kotlin
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
      ron
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
    blink-cmp
    blink-cmp-spell
    conform-nvim
    edge-nvim
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
    tokyonight-nvim
    treesitter
    which-key-nvim
  ];
  wrapRc = false; # Use ~/.config/nvim/init.lua
}
