{ pkgs, ... }:
{
  # Since we don't have a hardware-configuration.nix
  nixpkgs.hostPlatform = "x86_64-linux";

  wsl = {
    enable = true;
    defaultUser = "oahlen";
    useWindowsDriver = true;
  };

  modules = {
    apptainer.enable = true;

    podman = {
      enable = true;
      dockerCompat = true;
    };
  };

  programs = {
    dconf.enable = true;
    git.lfs.enable = true;
    ssh.startAgent = true;
  };

  users.users.oahlen = {
    uid = 1000;
    description = "Oscar Ahlén";
    isNormalUser = true;
    extraGroups = [
      "podman"
      "wheel"
    ];

    heim = import ./home.nix { inherit pkgs; };
  };

  system.stateVersion = "24.11";
}
