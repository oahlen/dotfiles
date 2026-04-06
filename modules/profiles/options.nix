{ lib, ... }:
{
  options = {
    environment = {
      systemPackages = lib.mkOption {
        type = lib.types.listOf lib.types.package;
        default = [ ];
        description = "Packages to include in the profile environment.";
      };

      pathsToLink = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ "/bin" ];
        description = "Paths to link in the profile environment.";
      };

      extraOutputsToInstall = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = "Extra outputs to install for packages in the profile environment.";
      };
    };
  };
}
