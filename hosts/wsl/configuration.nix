{
  config,
  pkgs,
  ...
}:
{
  # Since we don't have a hardware-configuration.nix
  nixpkgs.hostPlatform = "x86_64-linux";

  wsl = {
    enable = true;
    defaultUser = config.user.name;
    useWindowsDriver = true;
  };

  modules = {
    apptainer.enable = true;
    development.enable = true;
    podman.enable = true;
  };

  programs = {
    dconf.enable = true;
    git.lfs.enable = true;
    ssh.startAgent = true;
  };

  environment.systemPackages = with pkgs; [
    awscli2
    duckdb
    fastfetchMinimal
    nodejs # For Github Copilot
    pqrs
    trash-cli
    typst
    wl-clipboard
    xdg-utils
  ];

  system.stateVersion = "24.11";
}
