{ ... }:
{
  imports = [
    ./options.nix
    ./settings.nix

    ./features/desktop.nix
    ./features/gaming.nix
    ./features/gnome.nix
    ./features/laptop.nix
    ./features/niri.nix

    ./programs/apptainer.nix
    ./programs/podman.nix
    ./programs/virt-manager.nix
    ./programs/yubikey.nix

    ./services/intune.nix
    ./services/nix-gc-user.nix
    ./services/polkit-soteria.nix
    ./services/swayidle.nix
    ./services/swayosd.nix
    ./services/waybar.nix
    ./services/wlsunset.nix
  ];
}
