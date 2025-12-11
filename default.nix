let
  sources = import ./npins;
  pkgs = import sources.nixpkgs {
    config.allowUnfree = true;
  };
in
{
  hosts =
    let
      mkHost = modules: pkgs.nixos ([ ./modules/nixos.nix ] ++ modules);
    in
    {
      desktop = mkHost [ ./hosts/desktop/configuration.nix ];
      nixos = mkHost [
        ./hosts/wsl/configuration.nix
        "${sources.NixOS-WSL}/modules"
      ];
      xps15 = mkHost [ ./hosts/xps15/configuration.nix ];
    };

  envs =
    let
      mkEnv = module: pkgs.callPackage ./envs { packagesToInstall = (import module) pkgs; };
    in
    {
      generic = mkEnv ./envs/generic;
      wsl = mkEnv ./envs/wsl;
    };

  packages = import ./packages { inherit pkgs; };

  shells = import ./shells { inherit pkgs; };
}
