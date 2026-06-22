{
  pkgs,
  ...
}:
{
  profiles = {
    work.enable = true;
    wsl.enable = true;
  };

  features = {
    development.enable = true;
  };

  programs = {
    one-password.enable = true;
  };

  home = {
    packages = with pkgs; [
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
