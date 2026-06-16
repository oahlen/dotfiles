{
  pkgs,
  ...
}:
{
  profiles = {
    default.enable = true;
  };

  features = {
    development.enable = true;
  };

  programs = {
    windows-terminal.enable = true;
  };

  home = {
    packages = with pkgs; [
      _1password-cli
      awscli2
      duckdb
      fastfetch.minimal
      gh
      github-copilot-cli
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
  };
}
