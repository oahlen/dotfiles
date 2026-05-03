{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.apptainer;
in
{
  options.programs.apptainer.enable = lib.mkEnableOption "Apptainer.";

  config = lib.mkIf cfg.enable {
    programs.singularity = {
      enable = true;
      package = pkgs.apptainer;
    };

    environment.systemPackages = [ pkgs.gocryptfs ];
  };
}
