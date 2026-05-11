# shellcheck shell=sh

# shellcheck source=/dev/null
if [ -f /etc/profiles/per-user/oahlen/share/heim/session-vars.sh ]; then
  . /etc/profiles/per-user/oahlen/share/heim/session-vars.sh
fi

# shellcheck source=/dev/null
if [ -f "$HOME/.env" ]; then
  . "$HOME/.env"
fi
