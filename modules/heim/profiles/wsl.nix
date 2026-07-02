{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.profiles.wsl;
in
{
  options.profiles.wsl.enable = lib.mkEnableOption "WSL profile.";

  config = lib.mkIf cfg.enable {
    features = {
      cli.enable = true;
    };

    programs = {
      windows-terminal.enable = true;
    };

    home = {
      packages = with pkgs; [
        fastfetch.minimal
        trash-cli
        wl-clipboard
        xdg-utils
      ];

      sessionVariables = {
        COLORTERM = "truecolor";
      };
    };
  };
}
