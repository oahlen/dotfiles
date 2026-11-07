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
      fastfetch.enable = true;
      fd.enable = true;
      fish.enable = true;
      fzf.enable = true;
      ripgrep.enable = true;
      scripts.enable = true;
      yazi.enable = true;
    };

    home = {
      packages = with pkgs; [
        calc
        dos2unix
        dust
        eza
        jq
        procs
        rage
        tree
      ];

      sessionVariables = {
        CALCHISTFILE = "$HOME/.cache/calc_history";
        LESSHISTFILE = "$HOME/.local/share/less/history";
      };
    };
  };
}
