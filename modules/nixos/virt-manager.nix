{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.virt-manager;
in
{
  options.modules.virt-manager.enable = mkEnableOption "Whether to enable Virtual Machine Manager.";

  config = mkIf cfg.enable {
    virtualisation.libvirtd.enable = true;

    programs.dconf.enable = true;

    environment.systemPackages = with pkgs; [
      virt-manager
    ];

    users.users.${config.user.name}.extraGroups = [ "libvirtd" ];
  };
}
