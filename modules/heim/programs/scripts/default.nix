{
  config,
  lib,
  ...
}:
let
  cfg = config.programs.scripts;
in
{
  options.programs.scripts.enable = lib.mkEnableOption "custom scripts.";

  config = lib.mkIf cfg.enable {
    home = {
      files = {
        ".local/bin" = {
          source = ./bin;
          recursive = true;
        };
      };

      sessionPath = [ "$HOME/.local/bin" ];
    };
  };
}
