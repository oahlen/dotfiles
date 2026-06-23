{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.neovim;

  extraPackages = with pkgs; [
    harper
    lua-language-server
    nil
    shellcheck
    vscode-langservers-extracted
  ];
in
{
  options.programs.neovim.enable = lib.mkEnableOption "neovim.";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.customPackages.neovim ] ++ extraPackages;

    xdg.config.files = {
      "nvim" = {
        source = ./config;
        recursive = true;
      };
    };
  };
}
