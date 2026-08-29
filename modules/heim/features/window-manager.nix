{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.window-manager;
in
{
  options.features.window-manager = {
    enable = lib.mkEnableOption "the preferred window manager.";

    extraPackages = lib.mkOption {
      type = with lib.types; listOf package;
      default = [ ];
      description = "Extra packages to be installed alongside the window manager.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      foot.enable = true;
      niri.enable = true;
      noctalia.enable = true;
    };

    home = {
      packages =
        with pkgs;
        [
          hyprpicker
          wf-recorder
          wl-clipboard
          xwayland-satellite
        ]
        ++ cfg.extraPackages;

      pathsToLink = [
        "/share/applications"
        "/share/icons"
      ];
    };
  };
}
