{
  config,
  ...
}:
{
  pathsToLink = [
    "/bin"
    "/share/doc"
    "/share/man"
  ];

  extraOutputsToInstall = [
    "man"
    "doc"
  ];

  home.files = {
    ".profile".text = ''
      . ${config.loadSessionVariables}

      if [ -f "$HOME/.env" ]; then
        . "$HOME/.env"
      fi
    '';
  };

  overwrite = true;
}
