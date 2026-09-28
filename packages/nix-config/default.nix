{
  pkgs,
  runCommand,
  ...
}:
let
  settings = {
    allowed-users = "*";
    auto-optimise-store = true;
    builders = "";
    build-users-group = "nixbld";
    cores = 0;
    experimental-features = "nix-command flakes";
    flake-registry = "";
    extra-sandbox-paths = "";
    keep-derivations = true;
    keep-outputs = true;
    max-jobs = "auto";
    require-sigs = true;
    sandbox-fallback = false;
    sandbox = true;
    substituters = "https://cache.nixos.org/";
    system-features = "nixos-test benchmark big-parallel kvm";
    trusted-public-keys = "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=";
    trusted-substituters = "";
    trusted-users = "root";
    use-xdg-base-directories = true;
  };

  format = pkgs.formats.nixConf {
    inherit (pkgs.nix) version;
    package = pkgs.nix;
  };

  text = format.generate "nix.conf" settings;

  package = runCommand "standalone-nix-conf" { } ''
    mkdir -p $out/share/nix
    ln -s ${text} $out/share/nix/nix.conf
  '';

  nixConfig = "${package}/share/nix/nix.conf";

  activation = ''
    if [ "$(readlink -f /etc/nix/nix.conf)" != "${nixConfig}" ]; then
      echo "Linking /etc/nix/nix.conf ..."
      sudo mkdir -p /etc/nix
      sudo ln -sfn ${nixConfig} /etc/nix/nix.conf
      sudo systemctl restart nix-daemon 2>/dev/null || true
    fi
  '';
in
{
  inherit
    activation
    package
    ;
}
