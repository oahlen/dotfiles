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

  profiles =
    let
      mkProfile =
        modules:
        let
          evaluated = pkgs.lib.evalModules {
            specialArgs = { inherit pkgs; };
            modules = modules ++ [ ./modules/profiles ];
          };
        in
        pkgs.callPackage ./profiles/builder.nix {
          inherit (evaluated) config;
        };
    in
    {
      ubuntu = mkProfile [ ./profiles/ubuntu ];
      wsl = mkProfile [ ./profiles/wsl ];
    };

  packages = pkgs.customPackages;

  shells = import ./shells { inherit pkgs; };
}
