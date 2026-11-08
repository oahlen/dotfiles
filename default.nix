let
  pins = import ./npins;

  sources = pkgs.callPackage ./sources/generated.nix { };

  pkgs-unstable = import pins.nixos-unstable {
    config.allowUnfree = true;
  };

  pkgs = import pins.nixpkgs {
    config.allowUnfree = true;

    overlays = [
      (final: prev: {
        customPackages = import ./packages {
          pkgs = final;
          inherit pkgs-unstable sources;
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
        ./modules/microvm/host.nix
        "${pins.microvm}/nixos-modules/host"
        { _module.args = { inherit pkgs-unstable sources vms; }; }
      ]
      ++ modules
    );

  mkWslHost =
    modules:
    pkgs.nixos (
      [
        ./modules/nixos
        ./modules/wsl
        "${pins.NixOS-WSL}/modules"
        { _module.args = { inherit pkgs-unstable sources; }; }
      ]
      ++ modules
    );

  mkVm =
    modules:
    pkgs.nixos (
      [
        ./modules/nixos
        ./modules/microvm/guest.nix
        "${pins.microvm}/nixos-modules/microvm"
        { _module.args = { inherit pkgs-unstable sources; }; }
      ]
      ++ modules
    );

  vms = {
    devbox = mkVm [ ./vms/devbox/configuration.nix ];
    sandbox = mkVm [ ./vms/sandbox/configuration.nix ];
  };

  mkHome =
    modules:
    heim pkgs {
      modules = [
        ./modules/heim
        { _module.args = { inherit pkgs-unstable sources; }; }
      ]
      ++ modules;
    };
in
{
  hosts = {
    desktop = mkHost [ ./hosts/desktop/configuration.nix ];
    nixos = mkWslHost [ ./hosts/wsl/configuration.nix ];
    xps15 = mkHost [ ./hosts/xps15/configuration.nix ];
  };

  inherit vms;

  homes = {
    desktop = mkHome [ ./hosts/desktop/home.nix ];
    mac = mkHome [ ./hosts/mac/home.nix ];
    nixos = mkHome [ ./hosts/wsl/home.nix ];
    xps15 = mkHome [ ./hosts/xps15/home.nix ];
  }
  // {
    devbox = mkHome [ ./vms/devbox/home.nix ];
  };

  packages = pkgs.customPackages;

  shells = import ./shells { inherit pkgs; };
}
