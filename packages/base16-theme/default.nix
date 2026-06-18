{ runCommand }:
runCommand "base16.tmTheme" { } ''
  cp ${./base16.tmTheme} $out
''
