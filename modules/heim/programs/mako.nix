{
  config,
  lib,
  ...
}:
let
  cfg = config.programs.mako;
in
{
  options.programs.mako.enable = lib.mkEnableOption "mako.";

  config = lib.mkIf cfg.enable {
    xdg.config.files =
      let
        inherit (lib)
          concatStringsSep
          mapAttrsToList
          ;

        formatValue = v: if builtins.isBool v then if v then "true" else "false" else toString v;

        mkConfig = config: concatStringsSep "\n" (mapAttrsToList (k: v: "${k}=${formatValue v}") config);

        config = {
          font = "JetBrainsMono Nerd Font 11.5";

          anchor = "top-right";
          default-timeout = 10000;
          ignore-timeout = true;

          margin = 24;
          padding = 16;

          border-radius = 8;
          border-size = 2;
        };

        dark = {
          background-color = "#1a1b26";
          border-color = "#7dcfff";
          progress-color = "#292d40";
          text-color = "#a9b1d6";
        };

        light = {
          background-color = "#e6e7ed";
          border-color = "#006c86";
          progress-color = "#c8cbd8";
          text-color = "#343b58";
        };
      in
      {
        "mako/config".variants = {
          "dark" = {
            text = mkConfig (config // dark);
            default = true;
          };

          light.text = mkConfig (config // light);
        };
      };
  };
}
