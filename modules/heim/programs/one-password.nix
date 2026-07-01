{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.one-password;

  op = pkgs._1password-cli;

  op-signin = pkgs.writeShellApplication {
    name = "op-signin";

    runtimeInputs = [ op ];

    text = ''
      if [ -z "$OP_ACCOUNT" ]; then
        echo "Error: OP_ACCOUNT environment variable is not set"
        exit 1
      fi

      SESSION_FILE="''${XDG_CACHE_HOME:-$HOME/.cache}/op-session"

      if [ -f "$SESSION_FILE" ]; then
        # shellcheck source=/dev/null
        source "$SESSION_FILE"
      fi

      if ! op whoami >/dev/null 2>&1; then
        TOKEN="$(op signin --raw 2>/dev/null)" || { echo "Failed to sign in to 1Password"; exit 1; }
        (umask 077; echo "export OP_SESSION_''${OP_ACCOUNT}=\"$TOKEN\"" > "$SESSION_FILE")
      fi
    '';
  };

  op-password-picker = pkgs.writeShellApplication {
    name = "op-password-picker";

    runtimeInputs = with pkgs; [
      fzf
      jq
      op
      wl-clipboard
    ];

    text = ''
      SESSION_FILE="''${XDG_CACHE_HOME:-$HOME/.cache}/op-session"

      if [ -f "$SESSION_FILE" ]; then
        # shellcheck source=/dev/null
        source "$SESSION_FILE"
      fi

      if ! op whoami >/dev/null 2>&1; then
        echo "Not signed in to 1Password. Run 'op-signin' first."
        exit 1
      fi

      RESULT=$(op item list --format=json | jq -r ".[].title" | fzf)

      if [ -n "$RESULT" ]; then
        PASS=$(op item get "$RESULT" --fields password --reveal)
        wl-copy "$PASS"
      fi
    '';
  };
in
{
  options.programs.one-password.enable = lib.mkEnableOption "1password.";

  config = lib.mkIf cfg.enable {
    services.flatpak.packages = [ "com.onepassword.OnePassword" ];

    home.packages = [
      op
      op-password-picker
      op-signin
    ];
  };
}
