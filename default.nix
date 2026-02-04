let
  sources = import ./npins;
  pkgs = import sources.nixpkgs {
    config.allowUnfree = true;
  };
in
{
  hosts =
    let
      mkHost = modules: pkgs.nixos ([ ./modules ] ++ modules);
    in
    {
      desktop = mkHost [ ./hosts/desktop/configuration.nix ];
      nixos = mkHost [
        ./hosts/wsl/configuration.nix
        "${sources.NixOS-WSL}/modules"
      ];
      xps15 = mkHost [ ./hosts/xps15/configuration.nix ];
    };

  profiles =
    let
      mkProfile = module: pkgs.callPackage ./profiles { inherit module; };
    in
    {
      generic = mkProfile ./profiles/generic;
      wsl = mkProfile ./profiles/wsl;
    };

  packages = import ./packages { inherit pkgs; };

  shells = import ./shells { inherit pkgs; };
}
