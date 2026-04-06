{ pkgs, ... }:
{
  modules.development.enable = true;

  environment.systemPackages = with pkgs; [
    dconf
    fastfetchMinimal
    trash-cli
    wl-clipboard
    xdg-utils
  ];
}
