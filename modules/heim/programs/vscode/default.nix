{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.vscode;

  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;

  configDir = if isDarwin then "Library/Application Support/Code/User" else ".config/Code/User";

  settings = lib.importJSON ./settings.json;

  mkTheme = import ./theme.nix;

  themeSettings = {
    "window.autoDetectColorScheme" = true;
    "workbench.colorTheme" = "Dark Modern";
    "workbench.preferredDarkColorTheme" = "Dark Modern";
    "workbench.preferredLightColorTheme" = "Light Modern";

    "workbench.colorCustomizations" = {
      "[Dark Modern]" = (mkTheme { variant = config.colors.dark; }).workbench;
      "[Light Modern]" = (mkTheme { variant = config.colors.light; }).workbench;
    };

    "editor.tokenColorCustomizations" = {
      "[Dark Modern]".textMateRules = (mkTheme { variant = config.colors.dark; }).tokenColors;
      "[Light Modern]".textMateRules = (mkTheme { variant = config.colors.light; }).tokenColors;
    };
  };
in
{
  options.programs.vscode = {
    enable = lib.mkEnableOption "vscode.";

    installPackage = lib.mkOption {
      type = lib.types.bool;
      default = !isDarwin;
      description = "Whether to install VS Code and extensions through nix.";
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = lib.optional cfg.installPackage (
        pkgs.vscode-with-extensions.override {
          vscodeExtensions = with pkgs.vscode-extensions; [
            vscodevim.vim
          ];
        }
      );

      files."${configDir}/settings.json".text = builtins.toJSON (settings // themeSettings);

      files."${configDir}/keybindings.json".source = ./keybindings.json;
    };
  };
}
