{ ... }:
{
  imports = [
    ./options.nix
    ./settings.nix

    ./profiles/desktop.nix
    ./profiles/development.nix
    ./profiles/gaming.nix
    ./profiles/gnome.nix
    ./profiles/laptop.nix
    ./profiles/niri.nix

    ./programs/apptainer.nix
    ./programs/podman.nix
    ./programs/virt-manager.nix
    ./programs/yubikey.nix

    ./services/kanshi.nix
    ./services/polkit-soteria.nix
    ./services/swaybg.nix
    ./services/swayidle.nix
    ./services/swayosd.nix
    ./services/waybar.nix
    ./services/wlsunset.nix
  ];
}
