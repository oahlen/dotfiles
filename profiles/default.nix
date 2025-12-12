{
  buildEnv,
  packagesToInstall ? [ ],
  pkgs,
}:
let
  profile = buildEnv {
    name = "environment";

    paths = [
      pkgs.direnv
      pkgs.nix-direnv
    ]
    ++ (import ../shared/packages.nix { inherit pkgs; })
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
profile
// {
  switch = pkgs.writeShellScriptBin "switch" ''
    mkdir -p "$HOME/.local/state/nix/profiles"
    nix build ${profile} --profile "$HOME/.local/state/nix/profiles/profile"
    ln -sfn "$HOME/.local/state/nix/profiles/profile" "$HOME/.local/state/nix/profile"
  '';
}
