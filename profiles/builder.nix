{
  buildEnv,
  direnv,
  nix-direnv,
  writeShellScriptBin,
  packages ? [ ],
  enableDirenv ? false,
}:
let
  direnvPackages =
    if enableDirenv then
      [
        direnv
        nix-direnv
      ]
    else
      [ ];

  profile = buildEnv {
    name = "environment";

    paths = packages ++ direnvPackages;

    pathsToLink = [
      "/bin"
      "/share/man"
      "/share/doc"
    ]
    ++ (if enableDirenv then [ "/share/nix-direnv" ] else [ ]);

    extraOutputsToInstall = [
      "man"
      "doc"
    ];
  };
in
profile
// {
  switch = writeShellScriptBin "switch" ''
    mkdir -p "$HOME/.local/state/nix/profiles"
    nix build ${profile} --profile "$HOME/.local/state/nix/profiles/profile"
    ln -sfn "$HOME/.local/state/nix/profiles/profile" "$HOME/.local/state/nix/profile"
  '';
}
