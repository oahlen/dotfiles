{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apptainer;
in
{
  options.features.apptainer.enable = lib.mkEnableOption "Apptainer.";

  config = lib.mkIf cfg.enable {
    programs.singularity = {
      enable = true;
      package = pkgs.apptainer;
    };

    environment.systemPackages = [ pkgs.gocryptfs ];
  };
}
