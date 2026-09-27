{
  niri,
  pkgs,
  sources,
  symlinkJoin,
  writeShellScriptBin,
  writeText,
  ...
}:
let
  nixGL = import "${sources.nixGL.src}" {
    inherit pkgs;
    enable32bits = true;
    enableIntelX86Extensions = true;
  };

  # Create a wrapper for niri-session using nixGL
  niri-session-wrapper = writeShellScriptBin "niri-session" ''
    exec ${nixGL.auto.nixGLDefault}/bin/nixGL ${niri}/bin/niri-session "$@"
  '';

  wrapper-script = writeText "niri" ''
    #!/bin/bash
    source /etc/profile.d/nix.sh 2>/dev/null || true
    exec ${niri-session-wrapper}/bin/niri-session "$@"
  '';

  niri-service = writeText "niri.service" ''
    [Unit]
    Description=A scrollable-tiling Wayland compositor
    BindsTo=graphical-session.target
    Before=graphical-session.target
    Wants=graphical-session-pre.target
    After=graphical-session-pre.target

    Wants=xdg-desktop-autostart.target
    Before=xdg-desktop-autostart.target

    [Service]
    Slice=session.slice
    Type=notify
    ExecStart=${niri-session-wrapper}/bin/niri-session
  '';

  niri-shutdown-target = "${niri}/share/systemd/user/niri-shutdown.target";
  niri-portals-conf = "${niri}/share/xdg-desktop-portal/niri-portals.conf";

  niri-desktop = writeText "niri.desktop" ''
    [Desktop Entry]
    Name=Niri
    Comment=A scrollable-tiling Wayland compositor
    Exec=niri
    Type=Application
    DesktopNames=niri
  '';

  install-niri-system-files = writeShellScriptBin "install-niri-system-files" ''
    set -euo pipefail

    echo "Installing niri session files ..."

    sudo install -m 755 ${wrapper-script} /usr/local/bin/niri

    sudo install -Dm 644 ${niri-service} /usr/share/systemd/user/niri.service
    sudo install -Dm 644 ${niri-shutdown-target} /usr/share/systemd/user/niri-shutdown.target
    sudo install -Dm 644 ${niri-desktop} /usr/share/wayland-sessions/niri.desktop
    sudo install -Dm 644 ${niri-portals-conf} /usr/share/xdg-desktop-portal/niri-portals.conf

    echo "Done."
  '';
in
symlinkJoin {
  name = "niri";
  paths = [
    niri
    niri-session-wrapper
    install-niri-system-files
  ];
  postBuild = ''
    rm $out/bin/niri-session
    ln -s ${niri-session-wrapper}/bin/niri-session $out/bin/niri-session
  '';
}
