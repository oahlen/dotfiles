{
  config,
  lib,
  ...
}:
let
  cfg = config.features.firefox;
in
{
  options.features.firefox = {
    enable = lib.mkEnableOption "Firefox and policy management.";

    httpAllowlist = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      example = [
        "http://192.168.1.100"
        "http://nas.local"
      ];
      description = "Origins exempt from HTTPS-only mode, e.g. local NAS or HTTP-only intranet services.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;

      policies = {
        # Account & sync
        DisableAccounts = true;
        DisableFirefoxAccounts = true;
        DisableFirefoxScreenshots = true;
        DisablePocket = true;

        # Browser behaviour
        DisableSetDesktopBackground = true;
        DontCheckDefaultBrowser = true;
        DisableProfileImport = true;
        DisableProfileRefresh = true;
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
        NoDefaultBookmarks = true;

        # Privacy
        DisableTelemetry = true;
        DisableFeedbackCommands = true;
        DisableFormHistory = true;
        DisableFirefoxStudies = true;
        SearchSuggestEnabled = false;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
          EmailTracking = true;
        };

        # Security
        HttpsOnlyMode = "force_enabled";
        HttpAllowlist = cfg.httpAllowlist;
        SSLVersionMin = "tls1.2";

        # Extensions — lock down to an explicit allowlist, declaratively install uBlock Origin
        ExtensionSettings = {
          "*" = {
            blocked_install_message = "Extensions are managed declaratively via Nix.";
            installation_mode = "blocked";
          };
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
        };

        # Password & autofill
        PasswordManagerEnabled = false;
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;

        # UI
        Preferences = {
          "browser.uidensity" = {
            Value = 1; # compact
            Status = "default";
          };
        };

        # Misc
        UserMessaging = {
          ExtensionRecommendations = false;
          FeatureRecommendations = false;
          SkipOnboarding = true;
        };
      };
    };
  };
}
