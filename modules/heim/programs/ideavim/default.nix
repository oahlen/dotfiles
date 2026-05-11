{
  config,
  lib,
  ...
}:
let
  cfg = config.programs.ideavim;
in
{
  options.programs.ideavim.enable = lib.mkEnableOption "ideavim.";

  config = lib.mkIf cfg.enable {
    xdg.config.files = {
      "ideavim/.ideavimrc".source = ./.ideavimrc;
    };
  };
}
