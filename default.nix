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

  heim = import sources.nix-heim;
in
{
  hosts =
    let
      mkHost =
        modules:
        pkgs.nixos (
          [
            ./modules/nixos
            ./modules/heim/nixos.nix
            "${sources.nix-index-database}/nixos-module.nix"
            heim.nixosModules.default
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

  homes =
    let
      mkHome = modules: heim pkgs ([ ./modules/heim ] ++ modules);
    in
    {
      desktop = mkHome [ ./hosts/desktop/home.nix ];
      nixos = mkHome [ ./hosts/wsl/home.nix ];
      xps15 = mkHome [ ./hosts/xps15/home.nix ];
    };

  packages = pkgs.customPackages;

  shells = import ./shells { inherit pkgs; };
}
