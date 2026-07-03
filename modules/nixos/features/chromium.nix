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
  options.features.chromium = {
    enable = lib.mkEnableOption "Chromium and policy management.";

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
    programs.chromium = {
      enable = true;

      extensions = [
        "ddkjiahejlhfcafbddmgiahcphecmpfh" # uBlock Origin Lite
      ];

      extraOpts = {
        # Account & sync
        "BrowserSignin" = 0;
        "SyncDisabled" = true;

        # Browser behaviour
        "DefaultBrowserSettingEnabled" = false;
        "BackgroundModeEnabled" = false;
        "ChromeVariations" = 2;
        "NetworkPredictionOptions" = 2;
        "ShowFullUrlsInAddressBar" = true;
        "PromptForDownloadLocation" = true;

        # Privacy
        "BlockThirdPartyCookies" = cfg.blockThirdPartyCookies;
        "MetricsReportingEnabled" = false;
        "UrlKeyedAnonymizedDataCollectionEnabled" = false;
        "SearchSuggestEnabled" = false;
        "SpellCheckServiceEnabled" = false;
        "PromotionsEnabled" = false;
        "WebRtcTextLogCollectionAllowed" = false;

        # Safe browsing (keep enabled but disable privacy-invasive reporting)
        "SafeBrowsingDeepScanningEnabled" = false;
        "SafeBrowsingExtendedReportingEnabled" = false;
        "SafeBrowsingSurveysEnabled" = false;

        # Privacy sandbox
        "PrivacySandboxAdMeasurementEnabled" = false;
        "PrivacySandboxAdTopicsEnabled" = false;
        "PrivacySandboxPromptEnabled" = false;
        "PrivacySandboxSiteEnabledAdsEnabled" = false;
        "RelatedWebsiteSetsEnabled" = false;

        # Security
        "HttpsOnlyMode" = "force_enabled";
        "HttpsOnlyModeAllowlist" = cfg.httpAllowlist;
        "SitePerProcess" = true;
        "AudioSandboxEnabled" = true;
        "NetworkServiceSandboxEnabled" = true;
        "BlockExternalExtensions" = true;
        "ExtensionInstallBlocklist" = [ "*" ];
        "ExtensionInstallAllowlist" = [ "ddkjiahejlhfcafbddmgiahcphecmpfh" ];
        "DefaultSensorsSetting" = 2;
        "RemoteDebuggingAllowed" = false;
        "RemoteAccessHostAllowRemoteAccessConnections" = false;
        "RemoteAccessHostFirewallTraversal" = false;

        # DNS over HTTPS (automatic — use system/network DoH if available)
        "DnsOverHttpsMode" = "automatic";

        # Password & autofill
        "PasswordManagerEnabled" = false;
        "AutofillAddressEnabled" = false;
        "AutofillCreditCardEnabled" = false;

        # Spellcheck
        "SpellcheckEnabled" = true;
        "SpellcheckLanguage" = [
          "en"
          "sv-SE"
        ];

        # Media
        "EnableMediaRouter" = false;
      };
    };
  };
}
