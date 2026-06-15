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
    programs = {
      mangohud.enable = true;
    };

    home.packages = [ pkgs.heroic ];

    xdg.config.files = {
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
