{
  pkgs,
  ...
}:
{
  profiles = {
    wsl.enable = true;
  };

  features = {
    development.enable = true;
  };

  home = {
    packages = with pkgs; [
      _1password-cli
      awscli2
      duckdb
      gh
      pqrs
      typst
    ];

    sessionVariables = {
      AWS_CONFIG_FILE = "$HOME/.config/aws/config";
      AWS_SHARED_CREDENTIALS_FILE = "$HOME/.config/aws/credentials";
    };
  };
}
