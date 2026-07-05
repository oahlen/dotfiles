let
  pins = import ./npins;

  sources = pkgs.callPackage ./sources/generated.nix { };

  pkgs = import pins.nixpkgs {
    config.allowUnfree = true;

    overlays = [
      (final: prev: {
        customPackages = import ./packages {
          pkgs = final;
          inherit sources;
        };
      })
    ];
  };

  heim = import pins.nix-heim;

  mkHost =
    modules:
    pkgs.nixos (
      [
        ./modules/nixos
        "${pins.NixOS-WSL}/modules"
      ]
      ++ modules
    );

  mkHome =
    modules:
    heim pkgs {
      modules = [
        ./modules/heim
        {
          _module.args = { inherit sources; };
        }
      ]
      ++ modules;
    };
in
{
  hosts = {
    desktop = mkHost [ ./hosts/desktop/configuration.nix ];
    nixos = mkHost [ ./hosts/wsl/configuration.nix ];
    xps15 = mkHost [ ./hosts/xps15/configuration.nix ];
  };

  homes = {
    desktop = mkHome [ ./hosts/desktop/home.nix ];
    nixos = mkHome [ ./hosts/wsl/home.nix ];
    xps15 = mkHome [ ./hosts/xps15/home.nix ];
  };

  packages = pkgs.customPackages;

  shells = import ./shells { inherit pkgs; };
}
