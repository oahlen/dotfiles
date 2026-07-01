{ ... }:
{
  imports = [
    ./features/apptainer.nix
    ./features/audio.nix
    ./features/boot.nix
    ./features/chromium.nix
    ./features/core-apps.nix
    ./features/fonts.nix
    ./features/gaming.nix
    ./features/gnome.nix
    ./features/niri.nix
    ./features/podman.nix
    ./features/ssd.nix
    ./features/tailscale.nix
    ./features/virtualisation.nix
    ./features/wayland.nix
    ./features/yubikey.nix

    ./profiles/desktop.nix
    ./profiles/laptop.nix
    ./profiles/work.nix
    ./profiles/wsl.nix

    ./services/nix-gc-user.nix
    ./services/polkit-soteria.nix
    ./services/swayidle.nix
    ./services/swayosd.nix
    ./services/waybar.nix
    ./services/wlsunset.nix

    ./options.nix
    ./settings.nix
  ];
}
