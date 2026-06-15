{
  config,
  lib,
  ...
}:
let
  cfg = config.features.rust;
in
{
  options.features.rust.enable = lib.mkEnableOption "rust related features.";

  config = lib.mkIf cfg.enable {
    home = {
      sessionVariables = {
        CARGO_HOME = "$HOME/.local/share/cargo";
      };

      sessionPath = [
        "$HOME/.local/share/cargo/bin"
      ];
    };
  };
}
