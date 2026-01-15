{
  lib,
  pkgs,
  ...
}:
{
  nixpkgs = {
    # config.allowUnfree = true; Enable if nixpkgs.pkgs is not set

    flake = {
      source = lib.mkForce null;
      setFlakeRegistry = lib.mkForce false;
    };
  };

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

  environment.variables.NIX_PATH = lib.mkForce "nixpkgs=${pkgs.path}";

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
