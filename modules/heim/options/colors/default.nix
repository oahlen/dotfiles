{
  config,
  lib,
  ...
}:
let
  mkTheme = import ./mkTheme.nix;

  # Every subdirectory is a colorscheme: { mkTheme }: { dark; light; }
  schemes = lib.mapAttrs (name: _: import ./${name} { inherit mkTheme; }) (
    lib.filterAttrs (_: type: type == "directory") (builtins.readDir ./.)
  );
in
{
  options = {
    colorscheme = {
      name = lib.mkOption {
        type = lib.types.enum (lib.attrNames schemes);
        default = "aurora";
        description = "Name of the active colorscheme.";
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

    colorschemes = lib.mkOption {
      type = lib.types.attrsOf (lib.types.attrsOf lib.types.anything);
      internal = true;
      readOnly = true;
      description = "All available colorschemes, keyed by name, each with dark and light variants.";
    };

    colors = lib.mkOption {
      type = lib.types.attrsOf lib.types.anything;
      internal = true;
      readOnly = true;
      description = "Active colorscheme with dark and light variants (set automatically from colorscheme.name).";
    };
  };

  config = {
    colorschemes = schemes;
    colors = schemes.${config.colorscheme.name};
  };
}
