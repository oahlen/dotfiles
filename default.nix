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
            ./modules/nixos
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

  homes =
    let
      heim = import sources.nix-heim;
      mkHome = modules: heim pkgs ([ ./modules/heim ] ++ modules);
    in
    {
      desktop = mkHome [ ./homes/desktop/home.nix ];
      nixos = mkHome [ ./homes/nixos/home.nix ];
    };

  packages = pkgs.customPackages;

  shells = import ./shells { inherit pkgs; };
}
