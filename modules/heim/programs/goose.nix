{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.goose;
in
{
  options.programs.goose.enable = lib.mkEnableOption "goose, an AI coding agent CLI.";

  config = lib.mkIf cfg.enable {
    home = {
      packages = [ pkgs.customPackages.goose-cli ];

      files = {
        ".config/goose/.goosehints".text = ''
          You are running in a nono sandbox, some commands or file paths might not be available.

          When writing documentation, keep typical AI-sounding text and bullet style lists to a minimum and adhere to existing style.
          Never use em dashes or mannered prose!
        '';
      };
    };
  };
}
