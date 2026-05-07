{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.development;
in
{
  options.features.development.enable = lib.mkEnableOption "basic development features.";

  config = lib.mkIf cfg.enable {
    packages = with pkgs; [
      bat
      bat-extras.batman
      bottom
      calc
      curl
      customPackages.neovim
      dos2unix
      dust
      eza
      fd
      figlet
      fish
      github-copilot-cli
      gitui
      goose-cli
      jless
      just
      lua-language-server
      nil
      nixfmt-tree
      nix-prefetch-git
      nix-search-cli
      nix-tree
      npins
      pokeget-rs
      procs
      rage
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

    programs = {
      direnv.enable = true;
      fzf.enable = true;
      git.enable = true;
      jq.enable = true;
      ripgrep.enable = true;
    };

    home = {
      files = {
        ".bash_profile".source = ../config/bash/.bash_profile;
        ".bashrc".source = ../config/bash/.bashrc;
        ".ssh".source = ../config/ssh;
      };
    };

    xdg.config.files = {
      "bat".source = ../config/bat;
      "bottom".source = ../config/bottom;
      "fd".source = ../config/fd;
      "fish".source = ../config/fish;
      "gitui".source = ../config/gitui;
      "ideavim".source = ../config/ideavim;
      "nvim".source = ../config/nvim;
      "scripts".source = ../config/scripts;
      "tmuxp".source = ../config/tmuxp;
      "tmux".source = ../config/tmux;
      "yazi".source = ../config/yazi;

      "mimeapps.list".source = ../config/xdg/mimeapps.list;
      "user-dirs.conf".source = ../config/xdg/user-dirs.conf;
      "user-dirs.dirs".source = ../config/xdg/user-dirs.dirs;
    };
  };
}
