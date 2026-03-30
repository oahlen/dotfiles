{ ... }:
{
  imports = [
    ./options.nix

    ./profiles/development.nix

    ./programs/direnv.nix
  ];
}
