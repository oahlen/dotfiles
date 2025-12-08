{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.wsl;
in
{
  options.modules.wsl.enable = mkEnableOption "Whether to enable WSL.";

  config = mkIf cfg.enable {
    wsl = {
      enable = true;
      defaultUser = config.user.name;
      useWindowsDriver = true;
    };

    services.timesyncd.enable = true;

    programs.dconf.enable = true;

    environment.systemPackages = with pkgs; [
      fastfetchMinimal
      wl-clipboard
      xdg-utils
    ];
  };
}
