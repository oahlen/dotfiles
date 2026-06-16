{
  config,
  lib,
  ...
}:
let
  cfg = config.profiles.wsl;
in
{
  options.profiles.wsl.enable = lib.mkEnableOption "WSL profile.";

  config = lib.mkIf cfg.enable {
    # Since we don't have a hardware-configuration.nix
    nixpkgs.hostPlatform = "x86_64-linux";

    wsl = {
      enable = true;
      useWindowsDriver = true;
    };

    programs = {
      dconf.enable = true;
    };
  };
}
