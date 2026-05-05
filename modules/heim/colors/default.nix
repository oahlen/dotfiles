{
  config,
  lib,
  ...
}:
let
  schemes = {
    tokyonight = import ./tokyonight.nix;
  };
in
{
  options = {
    colorscheme = {
      name = lib.mkOption {
        type = lib.types.enum (lib.attrNames schemes);
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
