{
  default ? "dark",
  writeShellScriptBin,
}:
writeShellScriptBin "switch-theme" ''
  case "$1" in
      default)
          scheme="default"
          variant="${default}"
          ;;
      dark)
          scheme="prefer-dark"
          variant="dark"
          ;;
      light)
          scheme="prefer-light"
          variant="light"
          ;;
      *)
          echo "Usage: switch-theme [default|dark|light]" >&2
          exit 1
          ;;
  esac

  dconf write /org/gnome/desktop/interface/color-scheme "'$scheme'"

  heim-activate --variant "$variant"

  signal=$([ "$scheme" = "prefer-light" ] && echo USR2 || echo USR1)
  pkill -"$signal" foot || true

  makoctl reload
  notify-send "Application Theme" "Set to $1"
''
