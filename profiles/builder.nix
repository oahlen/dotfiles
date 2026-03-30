{
  buildEnv,
  direnv,
  nix-direnv,
  writeShellScriptBin,
  writeText,
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

  direnvrc = writeText "direnvrc" ''
    source ${nix-direnv}/share/nix-direnv/direnvrc
  '';

  direnvActivation =
    if enableDirenv then
      ''
        mkdir -p "$HOME/.config/direnv"
        ln -sfn ${direnvrc} "$HOME/.config/direnv/direnvrc"
      ''
    else
      "";

  profile = buildEnv {
    name = "environment";

    paths = packages ++ direnvPackages;

    pathsToLink = [
      "/bin"
      "/share/applications"
      "/share/doc"
      "/share/icons"
      "/share/man"
    ];

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

    ${direnvActivation}
  '';
}
