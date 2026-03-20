{ pkgs }:
pkgs.mkShell {
  NIX_SHELL = "Dotfiles";

  packages = with pkgs; [
    lua-language-server
    nodePackages.vscode-langservers-extracted # For css config files
  ];
}
