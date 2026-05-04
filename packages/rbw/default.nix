{
  makeWrapper,
  pinentry-curses,
  rbw,
  symlinkJoin,
}:
# Create an rbw wrapper with a pinentry program accessible
symlinkJoin {
  name = "rbw";
  paths = [
    pinentry-curses
    rbw
  ];
  nativeBuildInputs = [ makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/rbw
  '';
}
