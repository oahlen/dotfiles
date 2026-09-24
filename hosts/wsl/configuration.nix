{ ... }:
let
  user = "oahlen";
in
{
  wsl.defaultUser = user;

  defaultUser = {
    name = user;
    description = "Oscar Ahlén";
  };

  profiles = {
    wsl.enable = true;
  };

  features = {
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };

  programs = {
    git.lfs.enable = true;
    ssh.startAgent = true;
  };

  system.stateVersion = "24.11";
}
