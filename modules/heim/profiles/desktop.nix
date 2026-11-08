{
  config,
  lib,
  ...
}:
let
  cfg = config.profiles.desktop;
in
{
  options.profiles.desktop.enable = lib.mkEnableOption "the desktop profile.";

  config = lib.mkIf cfg.enable {
    features = {
      cli.enable = true;
    };

    home = {
      files = {
        "Pictures/Wallpapers" = {
          source = ./wallpapers;
          recursive = true;
          keepOutOfStore = true;
        };
      };
    };
  };
}
