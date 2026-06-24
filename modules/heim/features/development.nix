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
      copilot.enable = true;
      direnv.enable = true;
      git.enable = true;
      gitui.enable = true;
      neovim.enable = true;
    };

    home = {
      files = {
        ".agents/skills".source = "${sources.agentic-skills.src}/skills";
      };

      packages = with pkgs; [
        just
        nixfmt-tree
        nix-prefetch-git
        nix-search-cli
        nix-tree
        npins
        nvfetcher
        pastel
        statix
        stylua
        tokei
        typos
      ];

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
