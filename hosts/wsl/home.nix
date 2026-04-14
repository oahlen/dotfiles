{ pkgs, ... }:
{
  users.users.oahlen.heim = {
    modules = {
      development.enable = true;
    };

    home = {
      directory = "/home/oahlen";
      overwrite = true;

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
  };
}
