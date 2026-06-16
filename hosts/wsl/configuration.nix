{
  pkgs,
  ...
}:
{
  wsl.defaultUser = "oahlen";

  profiles = {
    wsl.enable = true;
  };

  features = {
    apptainer.enable = true;

    podman = {
      enable = true;
      dockerCompat = true;
    };
  };

  programs = {
    git.lfs.enable = true;
    ssh.startAgent = true;
  };

  users.users.oahlen = {
    uid = 1000;
    description = "Oscar Ahlén";
    isNormalUser = true;
    extraGroups = [
      "wheel"
    ];

    heim = import ./home.nix { inherit pkgs; };
  };

  system.stateVersion = "24.11";
}
