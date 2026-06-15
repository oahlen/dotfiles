{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.development;
in
{
  options.features.development.enable = lib.mkEnableOption "basic development features.";

  config = lib.mkIf cfg.enable {
    features = {
      cli.enable = true;
      dotnet.enable = true;
      nix-dev.enable = true;
      rust.enable = true;
    };

    programs = {
      git.enable = true;
      gitui.enable = true;
      neovim.enable = true;
    };

    home = {
      files = {
        ".agents/skills".source = ./skills;
        ".local/bin".source = ./scripts;
      };

      packages = with pkgs; [
        just
        stylua
        tokei
      ];
    };
  };
}
