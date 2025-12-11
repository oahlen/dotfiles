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
    mkdir -p "$HOME/.local/state/nix"
    nix build ${env} --profile "$HOME/.local/state/nix/profile"
    ln -sfn "$HOME/.local/state/nix/profile" "$HOME/.nix-profile"
  '';
}
