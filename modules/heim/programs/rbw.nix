{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.rbw;

  rbw = pkgs.customPackages.rbw;

  password-picker = pkgs.writeShellApplication {
    name = "password-picker";

    runtimeInputs =
      with pkgs;
      [
        fzf
        libnotify
        wl-clipboard
      ]
      ++ [ rbw ];

    text = ''
      if ! rbw unlocked >/dev/null 2>&1; then
        if ! rbw unlock; then
          exit
        fi
      fi

      RESULT=$(rbw list | fzf --height=100%)

      if [ -n "$RESULT" ]; then
        PASS=$(rbw get "$RESULT")
        wl-copy "$PASS"
        notify-send "Password Picker" "Entry copied to system clipboard"
      fi
    '';
  };
in
{
  options.programs.rbw.enable = lib.mkEnableOption "rbw.";

  config = lib.mkIf cfg.enable {
    home.packages = [
      password-picker
      rbw
    ];
  };
}
