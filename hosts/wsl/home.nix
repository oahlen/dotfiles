{
  pkgs,
  ...
}:
{
  features = {
    development.enable = true;
  };

  packages = with pkgs; [
    _1password-cli
    awscli2
    duckdb
    fastfetchMinimal
    pqrs
    trash-cli
    typst
    wl-clipboard
    xdg-utils
  ];
}
