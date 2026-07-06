{
  curl,
  fetchurl,
  lib,
  makeDesktopItem,
  runCommand,
  symlinkJoin,
  writeShellScriptBin,
  ...
}:
let
  version = "0.10.15";

  logseq-bin = writeShellScriptBin "logseq" ''
    set -e

    APPIMAGE_DIR="$HOME/.local/share/logseq"
    APPIMAGE_BIN="$APPIMAGE_DIR/Logseq-linux-x64-${version}.AppImage"
    DOWNLOAD_URL="https://github.com/logseq/logseq/releases/download/${version}/Logseq-linux-x64-${version}.AppImage"

    mkdir -p "$APPIMAGE_DIR"

    if [ ! -f "$APPIMAGE_BIN" ]; then
      echo "Downloading Logseq ${version}..."
      ${curl}/bin/curl -L --progress-bar -o "$APPIMAGE_BIN.tmp" "$DOWNLOAD_URL"
      mv "$APPIMAGE_BIN.tmp" "$APPIMAGE_BIN"
      chmod +x "$APPIMAGE_BIN"
      echo "Logseq installed successfully!"
    fi

    exec "$APPIMAGE_BIN" "$@"
  '';

  desktopItem = makeDesktopItem {
    name = "logseq";
    desktopName = "Logseq";
    comment = "A privacy-first, open-source platform for knowledge management and collaboration";
    exec = "logseq %u";
    icon = "logseq";
    terminal = false;
    type = "Application";
    categories = [
      "Office"
      "TextEditor"
    ];
    keywords = [
      "logseq"
      "notes"
      "knowledge"
      "outliner"
    ];
    mimeTypes = [ "x-scheme-handler/logseq" ];
  };

  logseqIcon = fetchurl {
    url = "https://raw.githubusercontent.com/logseq/logseq/master/resources/img/logo.png";
    hash = "sha256-CrWsCrKnZXdFTRllkuu7H7faRWdKYVA4CSrC38tfzDQ=";
  };

  logseqIconPkg = runCommand "logseq-icon" { } ''
    mkdir -p $out/share/icons/hicolor/256x256/apps
    cp ${logseqIcon} $out/share/icons/hicolor/256x256/apps/logseq.png
    mkdir -p $out/share/pixmaps
    cp ${logseqIcon} $out/share/pixmaps/logseq.png
  '';

  logseq = symlinkJoin {
    name = "logseq-${version}";
    paths = [
      logseq-bin
      desktopItem
      logseqIconPkg
    ];
    meta = {
      description = "A local-first, non-linear, outliner notebook for organizing and sharing your personal knowledge base";
      homepage = "https://logseq.com";
      license = lib.licenses.agpl3Only;
      platforms = [ "x86_64-linux" ];
      mainProgram = "logseq";
    };
  };
in
logseq
