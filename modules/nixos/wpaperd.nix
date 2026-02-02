{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.wpaperd;
  shared = import ./../shared/services.nix { inherit config lib; };

  sources = import ./../../npins;
  package = pkgs.callPackage "${sources.wpaperd}/nix";
in
{
  options.modules.wpaperd = {
    enable = mkEnableOption "Whether to enable wpaperd, a modern wallpaper daemon for Wayland.";
    # package = lib.mkPackageOption pkgs "wpaperd" { }; TODO Change to upstream after new release

    wallpapers = mkOption {
      type = lib.types.str;
      default = "$HOME/Pictures/Wallpapers";
      description = "The wallpaper directory.";
    };
    systemd.target = shared.mkWaylandSystemdTargetOption { };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ package ];

    systemd.user.services.wpaperd =
      let
        wpaperdConfig = pkgs.writeText "wpaperd.toml" ''
          [default]
          mode = "fit-border-color"

          [any]
          path = "${config.modules.wpaperd.wallpapers}"
        '';
      in
      shared.mkWaylandService {
        description = "Wallpaper daemon for Wayland";
        inherit (cfg.systemd) target;
        execStart = "${package}/bin/wpaperd -c ${wpaperdConfig}";
      };
  };
}
