{ ... }:
{
  imports = [
    ./features/apptainer.nix
    ./features/audio.nix
    ./features/boot.nix
    ./features/chromium.nix
    ./features/core-apps.nix
    ./features/desktop-environment.nix
    ./features/firefox.nix
    ./features/fonts.nix
    ./features/gaming.nix
    ./features/podman.nix
    ./features/ssd.nix
    ./features/syncthing.nix
    ./features/tailscale.nix
    ./features/virtualisation.nix
    ./features/wayland.nix
    ./features/window-manager.nix
    ./features/yubikey.nix

    ./profiles/desktop.nix
    ./profiles/laptop.nix
    ./profiles/work.nix

    ./services/nix-gc-user.nix
    ./services/noctalia.nix

    ./options.nix
    ./settings.nix
  ];
}
