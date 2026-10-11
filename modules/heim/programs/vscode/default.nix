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

      files."${configDir}/settings.json".source = ./settings.json;
      files."${configDir}/keybindings.json".source = ./keybindings.json;
    };
  };
}
