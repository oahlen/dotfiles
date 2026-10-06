{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.ghostty;

  themeName = variant: "${config.colorscheme.name}-${variant}";

  toKeyValue = lib.generators.toKeyValue {
    listsAsDuplicateKeys = true;
    mkKeyValue = lib.generators.mkKeyValueDefault { } " = ";
  };

  mkTheme = variant: {
    inherit (variant) background foreground;

    cursor-color = variant.white;

    selection-background = variant.selection.background;
    selection-foreground = variant.selection.foreground;

    palette = [
      "0=${variant.black}"
      "1=${variant.red}"
      "2=${variant.green}"
      "3=${variant.yellow}"
      "4=${variant.blue}"
      "5=${variant.purple}"
      "6=${variant.cyan}"
      "7=${variant.white}"
      "8=${variant.bright-black}"
      "9=${variant.bright-red}"
      "10=${variant.bright-green}"
      "11=${variant.bright-yellow}"
      "12=${variant.bright-blue}"
      "13=${variant.bright-purple}"
      "14=${variant.bright-cyan}"
      "15=${variant.bright-white}"
    ];
  };

  mkConfig = shellCommand: {
    font-family = "JetBrainsMono Nerd Font";
    font-size = 11.5;

    window-padding-x = 8;
    window-padding-y = 8;

    command = shellCommand;

    quit-after-last-window-closed = true;
    quit-after-last-window-closed-delay = "5m";

    theme = "light:${themeName "light"},dark:${themeName "dark"}";
  };

  launch-terminal = pkgs.writeShellScriptBin "launch-terminal" ''
    if [[ $# -lt 1 ]]; then
      echo "Usage: $0 <program>" >&2
      exit 1
    fi

    exec ${lib.getExe cfg.package} --class="com.mitchellh.ghostty.$1" -e "$1"
  '';
in
{
  options.programs.ghostty = {
    enable = lib.mkEnableOption "ghostty.";

    package = lib.mkPackageOption pkgs "ghostty" { };

    shell = lib.mkOption {
      type = with lib.types; either str package;
      default = pkgs.customPackages.fish;
      defaultText = lib.literalExpression "pkgs.customPackages.fish";
      description = "The shell to launch, either as a plain string or as a package to resolve an executable from.";
      example = "zsh";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.package
      launch-terminal
    ];

    xdg.config.files = {
      "ghostty/config.ghostty".text = toKeyValue (
        mkConfig (if lib.isDerivation cfg.shell then lib.getExe cfg.shell else cfg.shell)
      );

      "ghostty/themes/${themeName "dark"}".text = toKeyValue (mkTheme config.colors.dark);
      "ghostty/themes/${themeName "light"}".text = toKeyValue (mkTheme config.colors.light);
    };
  };
}
