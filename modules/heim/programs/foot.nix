{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.foot;
in
{
  options.programs.foot.enable = lib.mkEnableOption "foot.";

  config = lib.mkIf cfg.enable {
    packages = [ pkgs.foot ];

    xdg.config.files =
      let
        mkConfig = theme: {
          main = {
            dpi-aware = "no";
            font = "JetBrainsMono Nerd Font:size=11.5";
            shell = "${lib.getExe pkgs.fish}";
            initial-color-theme = "${theme}";
            pad = "10x10";
            term = "xterm-256color";
          };

          colors-dark = {
            background = "1a1b26";
            bright0 = "606a99";
            bright1 = "f7768e";
            bright2 = "9ece6a";
            bright3 = "e0af68";
            bright4 = "7aa2f7";
            bright5 = "bb9af7";
            bright6 = "7dcfff";
            bright7 = "c0caf5";
            foreground = "a9b1d6";
            regular0 = "292d40";
            regular1 = "f7768e";
            regular2 = "9ece6a";
            regular3 = "e0af68";
            regular4 = "7aa2f7";
            regular5 = "bb9af7";
            regular6 = "7dcfff";
            regular7 = "a9b1d6";
            selection-background = "292d40";
            selection-foreground = "c0caf5";
          };

          colors-light = {
            background = "e6e7ed";
            bright0 = "6c6e75";
            bright1 = "8c4351";
            bright2 = "385f0d";
            bright3 = "8f5e15";
            bright4 = "2959aa";
            bright5 = "5a3e8e";
            bright6 = "006c86";
            bright7 = "2b3048";
            foreground = "343b58";
            regular0 = "d7d9e2";
            regular1 = "8c4351";
            regular2 = "385f0d";
            regular3 = "8f5e15";
            regular4 = "2959aa";
            regular5 = "5a3e8e";
            regular6 = "006c86";
            regular7 = "343b58";
            selection-background = "2b3048";
            selection-foreground = "c8cbd8";
          };
        };
      in
      {
        "foot/foot.ini".variants = {
          dark = {
            text = lib.generators.toINI { } (mkConfig "dark");
            default = true;
          };

          light.text = lib.generators.toINI { } (mkConfig "light");
        };
      };
  };
}
