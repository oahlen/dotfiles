{ ... }:
{
  pathsToLink = [
    "/bin"
    "/share/doc"
    "/share/man"
    "/share/heim"
  ];

  extraOutputsToInstall = [
    "man"
    "doc"
  ];

  sessionVariables = {
    AWS_CONFIG_FILE = "$HOME/.config/aws/config";
    AWS_SHARED_CREDENTIALS_FILE = "$HOME/.config/aws/credentials";
    CALCHISTFILE = "$HOME/.cache/calc_history";
    CARGO_HOME = "$HOME/.local/share/cargo";
    COLORTERM = "truecolor";
    DOTNET_CLI_HOME = "$HOME/.local/share/dotnet";
    LESSHISTFILE = "$HOME/.local/share/less/history";
    TMUXP_PROGRESS = 0;

    PATH = "$HOME/.config/scripts:$HOME/.local/share/cargo/bin:$HOME/.local/share/dotnet/tools\${PATH:+:}$PATH";
  };

  overwrite = true;
}
