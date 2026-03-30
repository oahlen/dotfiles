{
  buildEnv,
  config,
  lib,
  writeShellScriptBin,
}:
let
  cfg = config.environment;

  profile = buildEnv {
    name = "environment";
    paths = cfg.packages;
    inherit (cfg) pathsToLink extraOutputsToInstall;
  };
in
profile
// {
  switch = writeShellScriptBin "switch" ''
    mkdir -p "$XDG_STATE_HOME/nix/profiles"
    nix build ${profile} --profile "$XDG_STATE_HOME/nix/profiles/profile"
    ln -sfn "$XDG_STATE_HOME/nix/profiles/profile" "$XDG_STATE_HOME/nix/profile"
  '';
}
