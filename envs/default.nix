{
  buildEnv,
  packagesToInstall ? [ ],
  pkgs,
}:
let
  env = buildEnv {
    name = "environment";

    paths = [
      pkgs.direnv
      pkgs.nix-direnv
    ]
    ++ (import ../shared/packages.nix pkgs)
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
    nix build ${env} --profile "$XDG_STATE_HOME/nix/profile"
  '';
}
