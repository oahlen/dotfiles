{
  config,
  lib,
  ...
}:
let
  cfg = config.programs.windows-terminal;

  capitalize =
    str:
    (lib.toUpper (builtins.substring 0 1 str)) + (builtins.substring 1 (builtins.stringLength str) str);

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

  profiles = {
    cmd = {
      guid = "{0caa0dad-35be-5f56-a8ff-afceeeaa6101}";
      hidden = false;
      name = "Command Prompt";
    };

    nixos = {
      guid = "{c397f356-5e7b-55bc-956b-8cb4b9762c26}";
      hidden = false;
      name = "NixOS";
      source = "Microsoft.WSL";
    };

    powershell = {
      guid = "{61c54bbd-c2c6-5271-96e7-009a87ff44bf}";
      hidden = false;
      name = "Windows PowerShell";
    };
  };

  base = {
    "$help" = "https://aka.ms/terminal-documentation";
    "$schema" = "https://aka.ms/terminal-profiles-schema";

    actions = [ ];
    copyFormatting = "none";
    copyOnSelect = false;

    defaultProfile = profiles.nixos.guid;

    keybindings = [
      {
        id = "Terminal.CopyToClipboard";
        keys = "ctrl+shift+c";
      }
      {
        id = "Terminal.PasteFromClipboard";
        keys = "ctrl+shift+v";
      }
    ];

    launchMode = "maximized";

    newTabMenu = [
      {
        type = "remainingProfiles";
      }
    ];

    profiles = {
      defaults = {
        bellStyle = "none";
        colorScheme = "${capitalize config.colorscheme.name} ${capitalize config.colorscheme.default}";

        font = {
          face = "JetBrainsMonoNL Nerd Font";
          features = {
            liga = 0;
            ss01 = 1;
          };
          size = 11;
          weight = "light";
        };

        icon = null;
        intenseTextStyle = "bold";
        startingDirectory = "%USERPROFILE%";
      };

      list = with profiles; [
        nixos
        powershell
        cmd
      ];
    };

    schemes = [
      (mkTheme "${capitalize config.colorscheme.name} Dark" config.colors.dark)
      (mkTheme "${capitalize config.colorscheme.name} Light" config.colors.light)
    ];

    theme = "system";
    themes = [ ];
  };
in
{
  options.programs.windows-terminal.enable = lib.mkEnableOption "Windows Terminal.";

  config = lib.mkIf cfg.enable {
    xdg.config.files = {
      "WindowsTerminal/settings.json".text = lib.generators.toJSON { } base;
    };
  };
}
