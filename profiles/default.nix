{
  buildEnv,
  module,
  pkgs,
}:
let
  config = import module { inherit pkgs; };

  profile = buildEnv {
    name = "environment";

    paths =
      config.packages
      ++ (import ../shared/packages.nix { inherit pkgs; })
      ++ (if config.enableDirenv then [ ] else [ ]);

    pathsToLink = [
      "/bin"
      "/share/man"
      "/share/doc"
    ]
    ++ (if config.enableDirenv then [ "/share/nix-direnv" ] else [ ]);

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
