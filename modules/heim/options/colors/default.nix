{
  config,
  lib,
  pkgs,
  sources,
  ...
}:
let
  schemes = {
    aurora = import ./aurora.nix {
      inherit
        pkgs
        sources
        ;
    };
  };
in
{
  options = {
    colorscheme = {
      name = lib.mkOption {
        type = lib.types.enum (lib.attrNames schemes);
        default = "aurora";
        description = "Name of the colorscheme to use.";
      };

      default = lib.mkOption {
        type = lib.types.enum [
          "dark"
          "light"
        ];
        default = "dark";
        description = "Default variant of the colorscheme.";
      };
    };

    colors = lib.mkOption {
      type = lib.types.attrsOf lib.types.anything;
      internal = true;
      readOnly = true;
      description = "Resolved colorscheme with dark and light variants (set automatically from colorscheme).";
    };
  };

  config.colors = schemes.${config.colorscheme.name};
}
