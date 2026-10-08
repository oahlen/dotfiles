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

  plugins = map (plugin: vimPlugins.${plugin.nix} or (buildPlugin sources.${plugin.nix})) (
    builtins.fromJSON (builtins.readFile ./config/plugins.json)
  );

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
  plugins = plugins ++ [
    treesitter
    configPlugin
  ];

  wrapRc = false;
}
