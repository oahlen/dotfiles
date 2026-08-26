{
  pkgs,
  ...
}:
let
  set-resolution-2k = pkgs.writeShellScriptBin "set-resolution-2k" ''
    niri msg output eDP-1 custom-mode 1920x1200@60
    niri msg output eDP-1 scale 1
    notify-send "Monitor" "Resolution set 1920x1200\nScaling set to 1.0"
  '';

  set-resolution-4k = pkgs.writeShellScriptBin "set-resolution-4k" ''
    niri msg output eDP-1 mode 3840x2400@60
    niri msg output eDP-1 scale 2
    notify-send "Monitor" "Resolution set 3840x2400\nScaling set to 2.0"
  '';
in
{
  profiles = {
    default.enable = true;
    work.enable = true;
  };

  features = {
    development.enable = true;
    window-manager.enable = true;
  };

  programs = {
    niri.extraConfig = ''
      output "eDP-1" {
          scale 2.0
      }
    '';

    rbw.enable = true;
  };

  home = {
    packages = with pkgs; [
      pinta
      set-resolution-2k
      set-resolution-4k
    ];
  };
}
