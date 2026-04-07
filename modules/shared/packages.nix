{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.packages;
in
{
  options.modules.packages.enable = lib.mkEnableOption "Whether to enable the core package set.";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bat
      bat-extras.batman
      bottom
      calc
      curl
      customPackages.homage
      customPackages.huevim
      customPackages.neovim
      dos2unix
      dust
      eza
      fd
      figlet
      fish
      fzf
      github-copilot-cli
      gitui
      jless
      jq
      just
      lua-language-server
      nil
      nixfmt-tree
      nix-prefetch-git
      nix-search-cli
      nix-tree
      npins
      opencode
      pokeget-rs
      procs
      rage
      ripgrep
      scooter
      sd
      shellcheck
      statix
      stylua
      tmux
      tmuxp
      tokei
      tree
      typos
      unzip
      vscode-langservers-extracted # For css config files
      wget
      xdg-user-dirs
      (yazi.override { optionalDeps = [ _7zz ]; })
      zip
      zoxide
    ];
  };
}
