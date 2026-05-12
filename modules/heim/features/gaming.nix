{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.gaming;
in
{
  options.features.gaming.enable = lib.mkEnableOption "gaming support.";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
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

      # Fixes for audio crackling
      "pipewire/pipewire.conf.d/99-custom-quantum.conf".text = ''
        context.properties = {
            default.clock.min-quantum = 1024
            default.clock.max-quantum = 8192
        }
      '';

      "pipewire/pipewire-pulse.conf.d/99-custom-quantum.conf".text = ''
        context.properties = {
            pulse.min.quantum = 1024/48000
            pulse.default.quantum = 1024/48000
            pulse.max.quantum = 8192/48000
        }
      '';
    };
  };
}
