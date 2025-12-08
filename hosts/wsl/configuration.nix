{ pkgs, ... }:
{
  # Since we don't have a hardware-configuration.nix
  nixpkgs.hostPlatform = "x86_64-linux";

  modules = {
    apptainer.enable = true;
    podman.enable = true;
    wsl.enable = true;
  };

  programs = {
    git.lfs.enable = true;
    ssh.startAgent = true;
  };

  environment.systemPackages = with pkgs; [
    awscli2
    duckdb
    nodejs # For Github Copilot
    pqrs
    trash-cli
    typst
  ];

  system.stateVersion = "24.11";
}
