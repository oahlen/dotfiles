{ ... }:
{
  imports = [
    ./options.nix

    ./profiles/development.nix
    ./profiles/niri.nix

    ./programs/direnv.nix
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
