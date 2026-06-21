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
      direnv.enable = true;
      git.enable = true;
      gitui.enable = true;
      neovim.enable = true;
    };

    home = {
      files = {
        ".agents/skills".source = ./skills;
      };

      packages = with pkgs; [
        customPackages.copilot
        just
        nixfmt-tree
        nix-prefetch-git
        nix-search-cli
        nix-tree
        npins
        nvfetcher
        statix
        stylua
        tokei
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
