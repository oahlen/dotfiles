{ lib, ... }:
let
  sources = import ../../npins;
in
{
  nix = {
    channel.enable = false;

    settings = {
      auto-optimise-store = true;
      experimental-features = "nix-command flakes";
      use-xdg-base-directories = true;
    };

    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
    '';

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  environment.variables.NIX_PATH = lib.mkForce "nixpkgs=${sources.nixpkgs}";

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
