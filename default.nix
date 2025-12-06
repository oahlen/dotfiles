let
  sources = import ./npins;
in
{
  hosts =
    let
      pkgs = import sources.nixpkgs {
        config.allowUnfree = true;
        overlays = [ (import ./packages/overlay.nix) ];
      };

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
      pkgs = import sources.nixpkgs {
        config.allowUnfree = true;
        overlays = [ (import ./packages/overlay.nix) ];
      };

      mkEnv = module: pkgs.callPackage ./envs { packagesToInstall = (import module) pkgs; };
    in
    {
      generic = mkEnv ./envs/generic;
    };

  packages = import ./packages {
    pkgs = import sources.nixpkgs { };
  };

  shells = import ./shells {
    pkgs = import sources.nixpkgs { };
  };
}
