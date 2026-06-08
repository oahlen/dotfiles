{
  config,
  lib,
  ...
}:
let
  cfg = config.programs.windows-terminal;

  mkTheme = name: variant: {
    inherit name;

    inherit (variant)
      foreground
      background
      black
      red
      green
      yellow
      blue
      purple
      cyan
      white
      ;

    brightBlack = variant.bright-black;
    brightRed = variant.bright-red;
    brightGreen = variant.bright-green;
    brightYellow = variant.bright-yellow;
    brightBlue = variant.bright-blue;
    brightPurple = variant.bright-purple;
    brightCyan = variant.bright-cyan;
    brightWhite = variant.bright-white;

    cursorColor = variant.white;
    selectionBackground = variant.selection.background;
  };
in
{
  options.programs.windows-terminal.enable = lib.mkEnableOption "Windows Terminal.";

  config = lib.mkIf cfg.enable {
    xdg.config.files = {
      "WindowsTerminal/settings.json".text = lib.generators.toJSON { } {
        schemes = [
          (mkTheme "${config.colorscheme.name} Dark" config.colors.dark)
          (mkTheme "${config.colorscheme.name} Light" config.colors.light)
        ];
      };
    };
  };
}
