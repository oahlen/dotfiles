{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.browser;
in
{
  options.features.browser = {
    enable = lib.mkEnableOption "Browser policy management.";

    blockThirdPartyCookies = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Block third-party cookies. Disable for work profiles using services like Microsoft Teams.";
    };

    httpAllowlist = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      example = [
        "192.168.1.100"
        "nas.local"
      ];
      description = "Hosts exempt from HTTPS-only mode, e.g. local NAS or HTTP-only intranet services.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      chromium = {
        enable = true;

        extensions = [
          "ddkjiahejlhfcafbddmgiahcphecmpfh" # uBlock Origin Lite
        ];

        extraOpts = {
          # Account & sync
          BrowserSignin = 0;
          SyncDisabled = true;

          # Browser behaviour
          DefaultBrowserSettingEnabled = false;
          BackgroundModeEnabled = false;
          ChromeVariations = 2;
          NetworkPredictionOptions = 2;
          ShowFullUrlsInAddressBar = true;
          PromptForDownloadLocation = true;

          # Privacy
          BlockThirdPartyCookies = cfg.blockThirdPartyCookies;
          MetricsReportingEnabled = false;
          UrlKeyedAnonymizedDataCollectionEnabled = false;
          SearchSuggestEnabled = false;
          SpellCheckServiceEnabled = false;
          PromotionsEnabled = false;
          WebRtcTextLogCollectionAllowed = false;

          # Safe browsing (keep enabled but disable privacy-invasive reporting)
          SafeBrowsingDeepScanningEnabled = false;
          SafeBrowsingExtendedReportingEnabled = false;
          SafeBrowsingSurveysEnabled = false;

          # Privacy sandbox
          PrivacySandboxAdMeasurementEnabled = false;
          PrivacySandboxAdTopicsEnabled = false;
          PrivacySandboxPromptEnabled = false;
          PrivacySandboxSiteEnabledAdsEnabled = false;
          RelatedWebsiteSetsEnabled = false;

          # Security
          HttpsOnlyMode = "force_enabled";
          HttpsOnlyModeAllowlist = cfg.httpAllowlist;
          SitePerProcess = true;
          AudioSandboxEnabled = false;
          NetworkServiceSandboxEnabled = true;
          BlockExternalExtensions = true;
          ExtensionInstallBlocklist = [ "*" ];
          ExtensionInstallAllowlist = [ "ddkjiahejlhfcafbddmgiahcphecmpfh" ];
          DefaultSensorsSetting = 2;
          RemoteDebuggingAllowed = false;
          RemoteAccessHostAllowRemoteAccessConnections = false;
          RemoteAccessHostFirewallTraversal = false;

          # DNS over HTTPS (automatic — use system/network DoH if available)
          DnsOverHttpsMode = "automatic";

          # Password & autofill
          PasswordManagerEnabled = false;
          AutofillAddressEnabled = false;
          AutofillCreditCardEnabled = false;

          # Spellcheck
          SpellcheckEnabled = true;
          SpellcheckLanguage = [
            "en"
            "sv-SE"
          ];

          # Media
          EnableMediaRouter = false;
        };
      };

      firefox.policies = {
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
        HttpAllowlist = map (host: "http://${host}") cfg.httpAllowlist;
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
