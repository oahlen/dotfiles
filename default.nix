let
  sources = import ./npins;
  pkgs = import sources.nixpkgs {
    config.allowUnfree = true;
    overlays = [
      (final: prev: {
        customPackages = import ./packages { pkgs = final; };
      })
    ];
  };
in
{
  hosts =
    let
      mkHost =
        modules:
        pkgs.nixos (
          [
            ./modules
            "${sources.nix-index-database}/nixos-module.nix"
          ]
          ++ modules
        );
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
      mkProfile = module: import ./profiles { inherit module pkgs; };
    in
    {
      generic = mkProfile ./profiles/generic;
      wsl = mkProfile ./profiles/wsl;
    };

  packages = pkgs.customPackages;

  shells = import ./shells { inherit pkgs; };
}
