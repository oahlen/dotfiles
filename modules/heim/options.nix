{
  config,
  lib,
  ...
}:
{
  options = {
    user = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "oahlen";
        description = "The name of the current user.";
      };

      fullName = lib.mkOption {
        type = lib.types.str;
        default = "Oscar Ahlén";
        description = "The full name of the current user";
      };
    };
  };

  config = {
    home.directory = "/home/${config.user.name}";
  };
}
