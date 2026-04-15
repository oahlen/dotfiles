{ ... }:
{
  imports = [
    ./home.nix
  ];

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

  system.stateVersion = "24.11";
}
