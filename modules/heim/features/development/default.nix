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
    programs = {
      bash.enable = true;
      bat.enable = true;
      bottom.enable = true;
      direnv.enable = true;
      fd.enable = true;
      fish.enable = true;
      fzf.enable = true;
      git.enable = true;
      gitui.enable = true;
      jq.enable = true;
      neovim.enable = true;
      ripgrep.enable = true;
      tmux.enable = true;
      yazi.enable = true;
      zoxide.enable = true;
    };

    home = {
      files = {
        ".local/bin".source = ./scripts;
      };

      packages = with pkgs; [
        calc
        curl
        dos2unix
        dust
        eza
        figlet
        jless
        just
        nixfmt-tree
        nix-prefetch-git
        nix-search-cli
        nix-tree
        npins
        nvfetcher
        pastel
        pokeget-rs
        procs
        rage
        scooter
        sd
        statix
        stylua
        tokei
        tree
        typos
        unzip
        wget
        zip
      ];

      sessionVariables = {
        CALCHISTFILE = "$HOME/.cache/calc_history";
        CARGO_HOME = "$HOME/.local/share/cargo";
        DOTNET_CLI_HOME = "$HOME/.local/share/dotnet";
        LESSHISTFILE = "$HOME/.local/share/less/history";
      };

      sessionPath = [
        "$HOME/.local/bin"
        "$HOME/.local/share/cargo/bin"
        "$HOME/.local/share/dotnet/tools"
      ];
    };
  };
}
