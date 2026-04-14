{ pkgs, ... }:
{
  users.users.oahlen.heim = {
    modules = {
      development.enable = true;
    };

    overwrite = true;

    home = {
      directory = "/home/oahlen";
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
  };
}
