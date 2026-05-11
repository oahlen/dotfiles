{
  pkgs,
  ...
}:
{
  features = {
    development.enable = true;
  };

  home.files = {
    ".profile".source = ./.profile;
  };

  packages = with pkgs; [
    _1password-cli
    awscli2
    duckdb
    fastfetchMinimal
    github-copilot-cli
    goose-cli
    pqrs
    trash-cli
    typst
    wl-clipboard
    xdg-utils
  ];
}
