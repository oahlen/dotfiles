{ pkgs, ... }:
{
  modules = {
    development.enable = true;
    direnv.enable = true;
  };

  environment.packages = with pkgs; [
    dconf
    fastfetchMinimal
    trash-cli
    wl-clipboard
    xdg-utils
  ];
}
