{ ... }:
{
  imports = [
    ./desktops/gnome.nix
    ./desktops/niri.nix

    ./features/apptainer.nix
    ./features/audio.nix
    ./features/boot.nix
    ./features/core-apps.nix
    ./features/fonts.nix
    ./features/gaming.nix
    ./features/podman.nix
    ./features/storage.nix
    ./features/virtualisation.nix
    ./features/wayland.nix
    ./features/yubikey.nix

    ./profiles/desktop.nix
    ./profiles/home.nix
    ./profiles/laptop.nix
    ./profiles/work.nix

    ./services/nix-gc-user.nix
    ./services/polkit-soteria.nix
    ./services/swayidle.nix
    ./services/swayosd.nix
    ./services/waybar.nix
    ./services/wlsunset.nix

    ./options.nix
    ./settings.nix
  ];

  heim.sharedModules = (import ../heim { }).imports;
}
