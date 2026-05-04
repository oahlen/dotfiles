{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.niri;

  mkTheme = variant: ''
    overview {
        backdrop-color "${variant.background}"
    }

    layout {
        focus-ring {
            active-color "${variant.cyan}"
            inactive-color "${variant.bright-black}"
        }
    }
  '';
in
{
  options.programs.niri = {
    enable = lib.mkEnableOption "the Niri window manager.";

    package = lib.mkPackageOption pkgs "niri" { };

    extraConfig = lib.mkOption {
      type = with lib.types; nullOr lines;
      default = null;
      description = "Extra config line to append to final niri config";
    };
  };

  config = lib.mkIf cfg.enable {
    packages = [ cfg.package ];

    xdg.config.files =
      let
        base = ''
          include "common.kdl"
          include "input.kdl"
          include "layout.kdl"
          include "binds.kdl"
          include "rules.kdl"
        '';
      in
      {
        "niri/config.kdl".text =
          base + lib.optionalString (cfg.extraConfig != null) ("\n" + cfg.extraConfig);

        "niri".source = ./config;

        "niri/theme.kdl".variants = {
          dark = {
            text = mkTheme config.colors.dark;
            default = config.colorscheme.default == "dark";
          };

          light = {
            text = mkTheme config.colors.light;
            default = config.colorscheme.default == "light";
          };
        };
      };
  };
}
