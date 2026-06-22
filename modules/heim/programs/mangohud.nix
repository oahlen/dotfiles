{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.mangohud;

  conf = lib.concatLines [
    "gpu_junction_temp"
    "gpu_mem_temp"
    "gpu_power"
    "gpu_temp"
    "vram"
  ];
in
{
  options.programs.mangohud.enable = lib.mkEnableOption "MangoHud.";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.mangohud ];

    xdg.config.files = {
      "MangoHud/MangoHud.conf".text = conf;
    };
  };
}
