{ lib, ... }:
{
  options = {
    environment = {
      packages = lib.mkOption {
        type = lib.types.listOf lib.types.package;
        default = [ ];
        description = "Packages to include in the profile environment.";
      };

      pathsToLink = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [
          "/bin"
          "/share/applications"
          "/share/doc"
          "/share/icons"
          "/share/man"
        ];
        description = "Paths to link in the profile environment.";
      };

      extraOutputsToInstall = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [
          "man"
          "doc"
        ];
        description = "Extra outputs to install for packages in the profile environment.";
      };
    };
  };
}
