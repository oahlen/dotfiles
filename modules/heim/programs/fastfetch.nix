{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.fastfetch;

  fetch = pkgs.writeShellApplication {
    name = "fetch";

    runtimeInputs = [
      cfg.package
      pkgs.pokeget-rs
    ];

    text = ''
      pokeget random --hide-name | fastfetch --color-title blue --color-keys cyan --logo-padding-top 2 --file-raw -
    '';
  };
in
{
  options.programs.fastfetch = {
    enable = lib.mkEnableOption "fastfetch.";
    package = lib.mkPackageOption pkgs "fastfetch" { };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ fetch ];
  };
}
