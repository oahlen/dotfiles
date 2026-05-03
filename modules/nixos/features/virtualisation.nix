{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.virtualisation;
in
{
  options.features.virtualisation.enable = lib.mkEnableOption "virtualisation.";

  config = lib.mkIf cfg.enable {
    virtualisation.libvirtd.enable = true;

    users.groups.libvirtd.members = config.users.groups.users.members;

    programs.dconf.enable = true;

    environment.systemPackages = [ pkgs.virt-manager ];
  };
}
