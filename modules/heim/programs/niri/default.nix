{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.niri;
in
{
  options.programs.niri = {
    enable = lib.mkEnableOption "the Niri window manager.";
    package = lib.mkPackageOption pkgs "niri" { };
  };

  config = lib.mkIf cfg.enable {
    packages = [ cfg.package ];

    xdg.config.files = {
      "niri/binds.kdl".source = ./binds.kdl;
      "niri/common.kdl".source = ./common.kdl;
      "niri/input.kdl".source = ./input.kdl;
      "niri/layout.kdl".source = ./layout.kdl;
      "niri/rules.kdl".source = ./rules.kdl;
    };
  };
}
