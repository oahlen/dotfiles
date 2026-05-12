{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.gitui;
in
{
  options.programs.gitui.enable = lib.mkEnableOption "gitui.";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.gitui ];

    xdg.config.files = {
      "gitui/key_bindings.ron".source = ./key_bindings.ron;
      "gitui/theme.ron".source = ./theme.ron;
    };
  };
}
