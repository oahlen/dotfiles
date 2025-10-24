#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

homeage install common
homeage install desktop

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install --or-update com.bitwarden.desktop
flatpak install --or-update com.github.PintaProject.Pinta
flatpak install --or-update md.obsidian.Obsidian
flatpak install --or-update org.inkscape.Inkscape
flatpak install --or-update org.keepassxc.KeePassXC
flatpak install --or-update org.mozilla.firefox
