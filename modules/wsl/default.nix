{ lib, ... }:
{
  # Since we don't have a hardware-configuration.nix
  nixpkgs.hostPlatform = "x86_64-linux";

  wsl = {
    enable = true;
    useWindowsDriver = true;
  };

  programs = {
    dconf.enable = true;

    # Usually needed for Windows tooling like remote VS Code server
    nix-ld.enable = lib.mkDefault true;
  };
}
