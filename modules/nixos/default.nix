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

    ./services/intune.nix
    ./services/nix-gc-user.nix
    ./services/polkit-soteria.nix
    ./services/swayidle.nix
    ./services/swayosd.nix
    ./services/waybar.nix
    ./services/wlsunset.nix
  ];
}
