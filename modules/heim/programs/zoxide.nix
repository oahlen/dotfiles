{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.zoxide;
in
{
  options.programs.zoxide.enable = lib.mkEnableOption "zoxide.";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.zoxide ];
  };
}
