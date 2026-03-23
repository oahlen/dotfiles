{
  fish,
  foot,
  makeWrapper,
  symlinkJoin,
  lib,
}:
symlinkJoin {
  name = "foot";
  paths = [ foot ];
  nativeBuildInputs = [ makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/foot \
      --add-flags '--override=main.shell=${lib.getExe fish}'
  '';
}
