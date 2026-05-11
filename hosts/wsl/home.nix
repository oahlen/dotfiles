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
    github-copilot-cli
    goose-cli
    pqrs
    trash-cli
    typst
    wl-clipboard
    xdg-utils
  ];

  sessionVariables = {
    AWS_CONFIG_FILE = "$HOME/.config/aws/config";
    AWS_SHARED_CREDENTIALS_FILE = "$HOME/.config/aws/credentials";
    COLORTERM = "truecolor";
  };
}
