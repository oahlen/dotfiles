{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.fastfetch;

  pokeget = pkgs.pokeget-rs;

  pokefetch = pkgs.writeShellApplication {
    name = "pokefetch";

    runtimeInputs = [
      cfg.package
      pokeget
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
    pokefetch.enable = lib.mkEnableOption "pokefetch." // {
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.package
    ]
    ++ lib.optionals cfg.pokefetch.enable [
      pokefetch
      pokeget
    ];
  };
}
