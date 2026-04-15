{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.virt-manager;
in
{
  options.modules.virt-manager.enable = lib.mkEnableOption "Virtual Machine Manager.";

  config = lib.mkIf cfg.enable {
    virtualisation.libvirtd.enable = true;

    programs.dconf.enable = true;

    environment.systemPackages = [ pkgs.virt-manager ];
  };
}
