{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.apptainer;
in
{
  options.modules.apptainer.enable = lib.mkEnableOption "Whether to enable Apptainer.";

  config = lib.mkIf cfg.enable {
    programs.singularity = {
      enable = true;
      package = pkgs.apptainer;
    };

    environment.systemPackages = [ pkgs.gocryptfs ];
  };
}
