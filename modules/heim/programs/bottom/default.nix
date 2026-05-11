{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.bottom;
in
{
  options.programs.bottom.enable = lib.mkEnableOption "bottom.";

  config = lib.mkIf cfg.enable {
    packages = [ pkgs.bottom ];

    xdg.config.files = {
      "bottom/bottom.toml".source = ./bottom.toml;
    };
  };
}
