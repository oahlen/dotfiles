{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.niri;
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
        config = ''
          include "common.kdl"
          include "input.kdl"
          include "layout.kdl"
          include "binds.kdl"
          include "rules.kdl"
        '';
      in
      {
        "niri/config.kdl".text =
          config + lib.optionalString (cfg.extraConfig != null) ("\n" + cfg.extraConfig);

        "niri".source = ./config;

        "niri/theme.kdl".variants = {
          dark = {
            text = ''
              overview {
                  backdrop-color "#1a1b26"
              }

              layout {
                  focus-ring {
                      active-color "#7dcfff"
                      inactive-color "#606a99"
                  }
              }
            '';
            default = true;
          };

          light.text = ''
            overview {
                backdrop-color "#c8cbd8"
            }

            layout {
                focus-ring {
                    active-color "#006c86"
                    inactive-color "#6c6e75"
                }
            }
          '';
        };
      };
  };
}
