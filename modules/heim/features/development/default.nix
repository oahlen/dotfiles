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
      git.enable = true;
      gitui.enable = true;
      neovim.enable = true;
    };

    home = {
      files = {
        ".agents/skills".source = ./skills;
      };

      packages = with pkgs; [
        customPackages.agent-container.script
        just
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
