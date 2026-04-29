{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.swaylock;
in
{
  options.programs.swaylock = {
    enable = lib.mkEnableOption "swaylock.";

    installPackage = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to install the swaylock package.";
    };
  };

  config = lib.mkIf cfg.enable {
    packages = if config.installPackage then [ pkgs.swaylock ] else [ ];

    xdg.config.files = {
      "swaylock/config".text = ''
        ignore-empty-password
        font=JetBrainsMono Nerd Font
        font-size=24

        color=1a1b26
        scaling=solid_color

        indicator-radius=120
        indicator-thickness=20

        inside-color=00000000
        inside-clear-color=00000000
        inside-caps-lock-color=00000000
        inside-ver-color=00000000
        inside-wrong-color=00000000

        line-color=606a99
        line-clear-color=e0af68
        line-caps-lock-color=bb9af7
        line-ver-color=7aa2f7
        line-wrong-color=f7768e

        ring-color=00000000
        ring-clear-color=e0af68
        ring-caps-lock-color=bb9af7
        ring-ver-color=7aa2f7
        ring-wrong-color=f7768e

        separator-color=00000000

        key-hl-color=7aa2f7
        bs-hl-color=e0af68
        caps-lock-key-hl-color=7aa2f7
        caps-lock-bs-hl-color=e0af68

        text-color=a9b1d6
        text-clear-color=e0af68
        text-caps-lock-color=bb9af7
        text-ver-color=7aa2f7
        text-wrong-color=f7768e

        layout-bg-color=00000000
        layout-border-color=00000000
        layout-text-color=a9b1d6
      '';
    };
  };
}
