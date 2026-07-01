{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.chromium;
in
{
  options.features.chromium.enable = lib.mkEnableOption "Chromium and policy management.";

  config = lib.mkIf cfg.enable {
    programs.chromium = {
      enable = true;

      extensions = [
        "ddkjiahejlhfcafbddmgiahcphecmpfh" # uBlock Origin Lite
      ];

      extraOpts = {
        "BrowserSignin" = 0;
        "SyncDisabled" = true;
        "PasswordManagerEnabled" = false;
        "SpellcheckEnabled" = true;
        "SpellcheckLanguage" = [
          "en-US"
          "sv-SE"
        ];
      };
    };

    environment.systemPackages = [ pkgs.chromium ];
  };
}
