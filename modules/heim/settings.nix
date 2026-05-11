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

  overwrite = true;
}
