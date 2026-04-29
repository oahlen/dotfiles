{
  config,
  lib,
  ...
}:
let
  cfg = config.programs.mangohud;
in
{
  options.programs.mangohud.enable = lib.mkEnableOption "MangoHud.";

  config = lib.mkIf cfg.enable {
    xdg.config.files = {
      "MangoHud/MangoHud.conf".text = ''
        gpu_junction_temp
        gpu_mem_temp
        gpu_power
        gpu_temp
        vram
      '';
    };
  };
}
