{
  pkgs,
  ...
}:
{
  profiles = {
    default.enable = true;
  };

  features = {
    development.enable = true;
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
      filen-cli
      keepassxc
      markdownlint-cli2
      pinta
      spotify
    ];
  };
}
