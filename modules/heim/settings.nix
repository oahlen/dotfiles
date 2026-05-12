{
  config,
  lib,
  ...
}:
{
  user = lib.mkDefault "oahlen";

  home = {
    files = {
      ".profile".text = ''
        . ${config.home.loadSessionVariables}

        if [ -f "$HOME/.env" ]; then
          . "$HOME/.env"
        fi
      '';
    };

    pathsToLink = [
      "/bin"
      "/share/doc"
      "/share/man"
    ];

    extraOutputsToInstall = [
      "man"
      "doc"
    ];
  };

  overwrite = true;
}
