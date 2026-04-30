{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.gaming;
in
{
  options.modules.gaming.enable = lib.mkEnableOption "gaming support.";

  config = lib.mkIf cfg.enable {
    packages = with pkgs; [
      heroic
      mangohud
    ];

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
