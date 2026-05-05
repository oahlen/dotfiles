{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.niri;

  base = ''
    include "binds.kdl"
    include "common.kdl"
    include "input.kdl"
    include "layout.kdl"
    include "mode.kdl"
    include "rules.kdl"
    include "theme.kdl"
  '';

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

    xdg.config.files = {
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

      "niri/mode.kdl".variants = {
        work = {
          text = ''
            animations {
                off
            }
          '';

          default = true;
        };

        vibe = {
          text = ''
            animations {
                on
            }
          '';
        };
      };
    };
  };
}
