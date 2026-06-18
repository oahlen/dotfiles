{
  runCommand,
}:
runCommand "scripts" { } ''
  mkdir -p $out/bin
  cp -r ${./bin}/. $out/bin
''
