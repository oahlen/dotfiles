{
  config,
  lib,
  pkgs,
  sources,
  ...
}:
let
  cfg = config.features.development;
in
{
  options.features.development.enable = lib.mkEnableOption "basic development features.";

  config = lib.mkIf cfg.enable {
    programs = {
      direnv.enable = true;
      git.enable = true;
      gitui.enable = true;
      goose.enable = true;
      neovim.enable = true;
      tmux.enable = true;
    };

    home = {
      packages = with pkgs; [
        gh
        jless
        nixfmt-tree
        nix-prefetch-git
        nix-search-cli
        npins
        nvfetcher
        pastel
        statix
        stylua
        tokei
        typos
      ];

      files = {
        ".agents/skills".source = "${sources.agentic-skills.src}/skills";
      };

      sessionVariables = {
        CARGO_HOME = "$HOME/.local/share/cargo";
        DOTNET_CLI_HOME = "$HOME/.local/share/dotnet";
      };

      sessionPath = [
        "$HOME/.local/share/cargo/bin"
        "$HOME/.local/share/dotnet/tools"
      ];
    };
  };
}
