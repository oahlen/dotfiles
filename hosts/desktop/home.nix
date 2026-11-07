{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  profiles = {
    desktop.enable = true;
  };

  features = {
    gaming.enable = true;
    window-manager.enable = true;
  };

  programs = {
    niri.extraConfig = ''
      output "DP-2" {
          variable-refresh-rate on-demand=true
      }
    '';

    rbw.enable = true;
  };

  home = {
    packages = with pkgs; [
      customPackages.hytale-launcher
      keepassxc
      pinta
      pkgs-unstable.tutanota-desktop
      spotify
    ];
  };
}
