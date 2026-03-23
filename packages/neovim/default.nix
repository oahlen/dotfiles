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
      rev = "4813e54e8310b3a917d4b094d016b200b27e6d3a";
      sha256 = "sha256-mnTrph9JMbMVhI6MyCrgUB31TYQQMgx+8RNnfgC6JS4=";
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
      rev = "7e591f4aa84df2a8870a511ab21a874dbb8aed81";
      sha256 = "sha256-l57KLoNx2kie67AJBdKU9XKS4hwVspL8n9TpqPgDQlo=";
    };

    meta.homepage = "https://github.com/oahlen/tokyonight.nvim";
  };

  plugins = with vimPlugins; [
    agentic-nvim
    blink-cmp
    blink-cmp-spell
    comment-nvim
    conform-nvim
    # csharpls-extended-lsp-nvim - Enable when merged https://github.com/Decodetalkers/csharpls-extended-lsp.nvim/pull/52
    friendly-snippets
    fzf-lua
    gitsigns-nvim
    heirline-nvim
    indent-blankline-nvim
    luasnip
    lz-n
    nvim-autopairs
    nvim-colorizer-lua
    nvim-lspconfig
    nvim-surround
    nvim-tree-lua
    nvim-web-devicons
    render-markdown-nvim
    shellcheck-nvim
    tokyonight-nvim
    which-key-nvim
    (nvim-treesitter.withPlugins (
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
    ))
  ];
in
wrapNeovimUnstable neovim-unwrapped {
  inherit plugins;
  wrapRc = false; # Use ~/.config/nvim/init.lua
}
