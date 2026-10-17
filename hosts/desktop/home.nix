{
  pkgs,
  ...
}:
{
  profiles = {
    default.enable = true;
  };

  features = {
    gaming.enable = true;
    window-manager.enable = true;
  };

  programs = {
    goose.desktop.enable = true;

    niri.extraConfig = ''
      output "DP-2" {
          variable-refresh-rate on-demand=true
      }
    '';

    rbw.enable = true;
    vscode.enable = true;
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
