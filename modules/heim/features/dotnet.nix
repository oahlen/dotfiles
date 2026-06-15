{
  config,
  lib,
  ...
}:
let
  cfg = config.features.dotnet;
in
{
  options.features.dotnet.enable = lib.mkEnableOption ".NET related features.";

  config = lib.mkIf cfg.enable {
    home = {
      sessionVariables = {
        DOTNET_CLI_HOME = "$HOME/.local/share/dotnet";
      };

      sessionPath = [
        "$HOME/.local/share/dotnet/tools"
      ];
    };
  };
}
