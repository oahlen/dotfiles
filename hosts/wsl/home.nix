{ ... }:
{
  users.users.oahlen.heim = {
    modules = {
      development.enable = true;
    };

    home = {
      directory = "/home/oahlen";
      overwrite = true;
    };
  };
}
