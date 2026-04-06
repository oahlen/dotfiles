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
    paths = cfg.systemPackages;
    inherit (cfg) pathsToLink extraOutputsToInstall;
  };
in
profile
// {
  switch = writeShellScriptBin "switch" ''
    TARGET=''${XDG_STATE_HOME:-$HOME/.local/state}
    mkdir -p "$TARGET/nix/profiles"
    nix build ${profile} --profile "$TARGET/nix/profiles/profile"
    ln -sfn "$TARGET/nix/profiles/profile" "$TARGET/nix/profile"
  '';
}
