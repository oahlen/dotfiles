{ pkgs }:
pkgs.mkShell {
  NIX_SHELL = "Playground";

  # Add testing packages here for evaluation
  packages = [ ];
}
