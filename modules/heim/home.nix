{ ... }:
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

  overwrite = true;
}
