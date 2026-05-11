{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.jq;

  colors = lib.concatStringsSep ":" [
    "1;33"
    "0;33"
    "0;33"
    "0;33"
    "0;32"
    "0;37"
    "0;37"
    "1;34"
  ];
in
{
  options.programs.jq.enable = lib.mkEnableOption "jq.";

  config = lib.mkIf cfg.enable {
    packages = [ pkgs.jq ];

    sessionVariables.JQ_COLORS = colors;
  };
}
