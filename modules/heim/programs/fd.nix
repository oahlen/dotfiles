{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.fd;

  ignore = lib.concatLines [
    ".cache"
    ".git"
  ];
in
{
  options.programs.fd.enable = lib.mkEnableOption "fd.";

  config = lib.mkIf cfg.enable {
    packages = [ pkgs.fd ];

    xdg.config.files = {
      "fd/ignore".text = ignore;
    };
  };
}
