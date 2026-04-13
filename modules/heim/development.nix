{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.development;
in
{
  options.modules.development.enable = lib.mkEnableOption "basic development features.";

  config = lib.mkIf cfg.enable {
    home = {
      # packages = with pkgs; [
      #   customPackages.environment
      #   direnv
      # ];

      files = {
        ".bash_profile".source = ./config/bash/.bash_profile;
        ".bashrc".source = ./config/bash/.bashrc;
        ".profile".source = ./config/profile/.profile;
        ".ssh".source = ./config/ssh;
      };
    };

    xdg.config.files = {
      "direnv/direnvrc".text = ''
        source ${pkgs.nix-direnv}/share/nix-direnv/direnvrc
      '';

      "bat".source = ./config/bat;
      "bottom".source = ./config/bottom;
      "fd".source = ./config/fd;
      "fish".source = ./config/fish;
      "git".source = ./config/git;
      "gitui".source = ./config/gitui;
      "ideavim".source = ./config/ideavim;
      "nvim".source = ./config/nvim;
      "ripgrep".source = ./config/ripgrep;
      "scripts".source = ./config/scripts;
      "tmuxp".source = ./config/tmuxp;
      "tmux".source = ./config/tmux;
      "yazi".source = ./config/yazi;

      "mimeapps.list".source = ./config/xdg/mimeapps.list;
      "user-dirs.conf".source = ./config/xdg/user-dirs.conf;
      "user-dirs.dirs".source = ./config/xdg/user-dirs.dirs;
    };
  };
}
