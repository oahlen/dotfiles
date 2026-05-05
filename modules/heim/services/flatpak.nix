{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.flatpak;

  mapEntry =
    entry:
    if builtins.isString entry then
      "flathub " + entry + "\n"
    else
      entry.repository + " " + entry.ref + "\"\n";

  flatpak-sync = pkgs.writeShellScriptBin "flatpak-sync" ''
    ${lib.concatMapStrings (
      x: "flatpak remote-add --if-not-exists " + x.name + " " + x.location + "\n"
    ) cfg.repositories}
    ${lib.concatMapStrings (x: "flatpak install --or-update ${mapEntry x}\n") cfg.packages}
  '';
in
{
  options.services.flatpak = {
    repositories = lib.mkOption {
      type = lib.types.listOf (
        lib.types.submodule {
          options = {
            name = lib.mkOption {
              type = lib.types.str;
              description = "The flatpak repository name";
            };
            location = lib.mkOption {
              type = lib.types.str;
              description = "The flatpak repository location";
            };
          };
        }
      );

      description = " The flatpak repositories to configure";
      default = [
        {
          name = "flathub";
          location = "https://flathub.org/repo/flathub.flatpakrepo";
        }
      ];
    };

    packages = lib.mkOption {
      type = lib.types.listOf (
        lib.types.either (lib.types.submodule {
          options = {
            repository = lib.mkOption {
              type = lib.types.str;
              description = "The flatpak repository";
              default = "flathub";
            };
            ref = lib.mkOption {
              type = lib.types.str;
              description = "The flatpak package reference";
            };
          };
        }) lib.types.str
      );
      description = "The flatpak packages to install";
      default = [ ];
    };
  };

  config = lib.mkIf (builtins.length cfg.packages > 0) {
    packages = [ flatpak-sync ];
  };
}
