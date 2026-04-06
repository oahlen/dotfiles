{ ... }:
{
  imports = [
    ./options.nix

    ./development.nix
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
