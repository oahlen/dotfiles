{
  callPackage,
  niri,
  pkgs,
  symlinkJoin,
  writeShellScriptBin,
}:
let
  sources = callPackage ../../sources/generated.nix { };

  nixGL = import "${sources.nixGL.src}" {
    inherit pkgs;
    enable32bits = true;
    enableIntelX86Extensions = true;
  };

  # Create a wrapper for niri-session using nixGL
  niri-session-wrapper = writeShellScriptBin "niri-session" ''
    exec ${nixGL.auto.nixGLDefault}/bin/nixGL ${niri}/bin/niri-session "$@"
  '';
in
symlinkJoin {
  name = "niri";
  paths = [ niri ];
  postBuild = ''
    rm $out/bin/niri-session
    ln -s ${niri-session-wrapper}/bin/niri-session $out/bin/niri-session
  '';
}
