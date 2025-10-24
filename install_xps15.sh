#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

homeage install common
homeage install xps15

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install --or-update com.github.PintaProject.Pinta
flatpak install --or-update org.chromium.Chromium
flatpak install --or-update org.inkscape.Inkscape
flatpak install --or-update org.mozilla.firefox

flatpak install --or-update https://downloads.1password.com/linux/flatpak/1Password.flatpakref \
    || echo "1Password install failed (optional)"
