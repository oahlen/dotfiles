{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.cli;
in
{
  options.features.cli.enable = lib.mkEnableOption "CLI programs.";

  config = lib.mkIf cfg.enable {
    programs = {
      bash.enable = true;
      bat.enable = true;
      bottom.enable = true;
      fd.enable = true;
      fish.enable = true;
      fzf.enable = true;
      jq.enable = true;
      ripgrep.enable = true;
      tmux.enable = true;
      yazi.enable = true;
      zoxide.enable = true;
    };

    home = {
      packages = with pkgs; [
        calc
        curl
        dos2unix
        dust
        eza
        figlet
        jless
        pastel
        pokeget-rs
        procs
        rage
        scooter
        sd
        tree
        typos
        unzip
        wget
        zip
      ];

      files = {
        ".local/bin".source = ./bin;
      };

      sessionPath = [
        "$HOME/.local/bin"
      ];

      sessionVariables = {
        CALCHISTFILE = "$HOME/.cache/calc_history";
        LESSHISTFILE = "$HOME/.local/share/less/history";
      };
    };
  };
}
