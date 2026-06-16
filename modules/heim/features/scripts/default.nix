{
  config,
  lib,
  ...
}:
let
  cfg = config.features.scripts;
in
{
  options.features.scripts.enable = lib.mkEnableOption "custom scripts collection.";

  config = lib.mkIf cfg.enable {
    home = {
      files = {
        ".local/bin".source = ./bin;
      };

      sessionPath = [
        "$HOME/.local/bin"
      ];
    };
  };
}
