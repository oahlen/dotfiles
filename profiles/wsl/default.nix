{ pkgs }:
{
  enableDirenv = true;

  packages = with pkgs; [
    dconf
    fastfetchMinimal
    trash-cli
    wl-clipboard
    xdg-utils
  ];
}
