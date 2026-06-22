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
        pokeget-rs
        procs
        rage
        scooter
        sd
        tree
        unzip
        wget
        zip
      ];

      files = {
        ".local/bin/doscleanup".source = ./bin/doscleanup;
        ".local/bin/external-ip".source = ./bin/external-ip;
        ".local/bin/kernels".source = ./bin/kernels;
        ".local/bin/nix-kernels".source = ./bin/nix-kernels;
        ".local/bin/show-gc-roots".source = ./bin/show-gc-roots;
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
