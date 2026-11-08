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
      development.enable = true;
    };

    programs = {
      windows-terminal.enable = true;
      fastfetch.package = pkgs.fastfetch.minimal;
    };

    home = {
      packages = with pkgs; [
        wl-clipboard
        xdg-utils
      ];

      sessionVariables = {
        COLORTERM = "truecolor";
      };
    };
  };
}
