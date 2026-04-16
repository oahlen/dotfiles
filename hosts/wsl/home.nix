{ pkgs, ... }:
{
  users.users.oahlen = {
    uid = 1000;
    description = "Oscar Ahlén";
    isNormalUser = true;
    extraGroups = [
      "podman"
      "wheel"
    ];

    heim = {
      modules = {
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
    };
  };
}
