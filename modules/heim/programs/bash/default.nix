{
  config,
  lib,
  ...
}:
let
  cfg = config.programs.bash;
in
{
  options.programs.bash.enable = lib.mkEnableOption "bash.";

  config = lib.mkIf cfg.enable {
    home.files = {
      ".bash_profile".source = ./.bash_profile;
      ".bashrc".source = ./.bashrc;
    };
  };
}
