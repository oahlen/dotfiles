{ ... }:
{
  imports = [
    ./desktops/gnome.nix
    ./desktops/niri.nix

    ./features/containers.nix
    ./features/gaming.nix
    ./features/security-key.nix
    ./features/virtualisation.nix

    ./profiles/desktop.nix
    ./profiles/home.nix
    ./profiles/laptop.nix
    ./profiles/work.nix

    ./programs/apptainer.nix

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
