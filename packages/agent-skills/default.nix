{ pkgs }:
pkgs.runCommand "agent-skills" { } ''
  cp -r ${./skills}/. $out
''
