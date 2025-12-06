{
  buildEnv,
  packagesToInstall ? [ ],
  pkgs,
}:
let
  env = buildEnv {
    name = "environment";

    paths =
      with pkgs;
      [
        direnv
        nix-direnv
      ]
      ++ packagesToInstall;

    pathsToLink = [
      "/share/man"
      "/share/doc"
      "/share/nix-direnv"
      "/bin"
    ];

    extraOutputsToInstall = [
      "man"
      "doc"
    ];
  };
in
env
// {
  switch = pkgs.writeShellScriptBin "switch" ''
    nix-env --set ${env} "$@"
  '';
}
