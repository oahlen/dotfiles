{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.fuzzel;
in
{
  options.programs.fuzzel.enable = lib.mkEnableOption "fuzzel.";

  config = lib.mkIf cfg.enable {
    packages = [ pkgs.fuzzel ];

    xdg.config.files =
      let
        config = {
          main = {
            dpi-aware = "no";
            font = "JetBrainsMono Nerd Font:size=11.5";
            horizontal-pad = 24;
            icons-enabled = "no";
            inner-pad = 8;
            line-height = 16;
            prompt = "> ";
            terminal = "foot -e";
            use-bold = "yes";
            vertical-pad = 20;
            width = 40;
          };

          border = {
            radius = 8;
            width = 2;
          };
        };

        dark = {
          colors = {
            background = "1a1b26ff";
            border = "7dcfffff";
            input = "a9b1d6ff";
            match = "e0af68ff";
            prompt = "9ece6aff";
            selection = "292d40ff";
            selection-match = "ff9e64ff";
            selection-text = "c0caf5ff";
            text = "a9b1d6ff";
          };
        };

        light = {
          colors = {
            background = "e6e7edff";
            border = "006c86ff";
            input = "343b58ff";
            match = "8f5e15ff";
            prompt = "385f0dff";
            selection = "c8cbd8ff";
            selection-match = "965027ff";
            selection-text = "2b3048ff";
            text = "343b58ff";
          };
        };
      in
      {
        "fuzzel/fuzzel.ini".variants = {
          dark = {
            text = lib.generators.toINI { } (config // dark);
            default = true;
          };

          light.text = lib.generators.toINI { } (config // light);
        };
      };
  };
}
