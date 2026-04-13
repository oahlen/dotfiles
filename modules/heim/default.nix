{ ... }:
{
  imports = [
    ./development.nix
    ./niri.nix
  ];

  home = {
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
