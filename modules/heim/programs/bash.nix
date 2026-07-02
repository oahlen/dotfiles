{
  config,
  lib,
  ...
}:
let
  cfg = config.programs.bash;

  profile = ''
    # Include .profile if it exists
    [[ -f ~/.profile ]] && . "$HOME/.profile"

    # Include .bashrc if it exists
    [[ -f ~/.bashrc ]] && . "$HOME/.bashrc"

    ${cfg.extraProfile}
  '';

  rc = ''
    # Commands that should be applied only for interactive shells.
    [[ $- == *i* ]] || return

    HISTFILESIZE=100000
    HISTIGNORE=ls:cd:exit
    HISTSIZE=10000

    shopt -s histappend
    shopt -s checkwinsize
    shopt -s extglob
    shopt -s globstar
    shopt -s checkjobs

    alias ..='cd ..'

    alias ls='eza'
    alias la='eza -a'
    alias ll='eza -l'
    alias lla='eza -la'
    alias lt='eza --tree'

    PS1='[\u@\h \W]\$ '

    ${cfg.extraRC}
  '';
in
{
  options.programs.bash = {
    enable = lib.mkEnableOption "bash.";

    extraProfile = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Extra lines appended to .bash_profile.";
    };

    extraRC = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Extra lines appended to .bashrc.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.files = {
      ".bash_profile".text = profile;
      ".bashrc".text = rc;
    };
  };
}
