{ ... }:
{
  imports = [
    ./options.nix

    ./development.nix
    ./direnv.nix
    ./niri.nix
  ];

  environment = {
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
}
