{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.tailscale.nginx-cert-renewal;

  certFile = "/etc/nginx/${cfg.domainName}.crt";
  keyFile = "/etc/nginx/${cfg.domainName}.key";
in
{
  options.services.tailscale.nginx-cert-renewal = {
    enable = lib.mkEnableOption "Whether to enable Tailscale TLS certificate renewal for NGINX";

    domainName = lib.mkOption {
      type = lib.types.str;
      description = "The fully qualified domain name to pass to tailscale cert.";
      example = "machine.tail-name.ts.net";
    };

    dates = lib.mkOption {
      type = lib.types.str;
      description = "systemd OnCalendar dates specification for how often to renew. See systemd.time(7).";
      default = "weekly";
      example = "daily";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.tailscale-nginx-cert-renewal = {
      description = "Renew Tailscale TLS certificate for nginx";
      after = [
        "network-online.target"
        "tailscaled.service"
      ];
      wants = [ "network-online.target" ];
      requires = [ "tailscaled.service" ];

      script = ''
        DOMAIN="${cfg.domainName}"
        CERT_DEST="${certFile}"
        KEY_DEST="${keyFile}"

        TMPDIR=$(mktemp -d)
        trap 'rm -rf "$TMPDIR"' EXIT

        CERT_TMP="$TMPDIR/$DOMAIN.crt"
        KEY_TMP="$TMPDIR/$DOMAIN.key"

        echo "Requesting certificate for $DOMAIN ..."
        ${pkgs.tailscale}/bin/tailscale cert \
          --cert-file="$CERT_TMP" \
          --key-file="$KEY_TMP" \
          "$DOMAIN"

        # Check if the new cert differs from the existing one.
        # tailscale cert returns the cached certificate when it is still valid,
        # so we only install and restart nginx when the cert has actually changed.
        if [ -f "$CERT_DEST" ] && ${pkgs.diffutils}/bin/cmp -s "$CERT_TMP" "$CERT_DEST"; then
          echo "Certificate unchanged, skipping install ..."
          exit 0
        fi

        echo "Installing new certificate and key..."
        install -m 644 -o nginx -g nginx "$CERT_TMP" "$CERT_DEST"
        install -m 600 -o nginx -g nginx "$KEY_TMP" "$KEY_DEST"

        echo "Restarting nginx..."
        systemctl restart nginx.service
        echo "Done."
      '';

      serviceConfig.Type = "oneshot";

      # Do not start and delay when switching configurations.
      restartIfChanged = false;
    };

    systemd.timers.tailscale-nginx-cert-renewal = {
      description = "Timer for Tailscale TLS certificate renewal";
      wantedBy = [ "timers.target" ];

      timerConfig = {
        OnCalendar = cfg.dates;
        Persistent = true;
        RandomizedDelaySec = "6h";
      };
    };
  };
}
