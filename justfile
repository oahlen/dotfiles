set positional-arguments

# Show available commands
help:
    @just --list --unsorted

# Enter the bootstrap shell environment
@bootstrap:
    nix-shell shells/bootstrap

# Open the pinned nixpkgs release page
@sources:
    url=$(jq -r '.pins.nixpkgs.url' npins/sources.json); xdg-open "${url%/*}"

# Update sources to the latest version
@update:
    npins update

# Check the current host configuration
@check host:
    nix build -f . "hosts.$1.config.system.build.toplevel"

# Run nixos-rebuild boot for the current host
@boot:
    nixos-rebuild boot -f . -A "hosts.$(hostname)" --quiet --no-reexec --sudo

# Run nixos-rebuild switch for the current host
@switch:
    nixos-rebuild switch -f . -A "hosts.$(hostname)" --quiet --no-reexec --sudo

# Build and switch to the specified profile
@profile name:
    nix run -f . "profiles.$1.switch"

# Build the specified package
@build package:
    nix build -f . "packages.$1"

# Run the specified package
@run package:
    nix run -f . "packages.$1"

# Enter the specified shell
@shell name:
    nix-shell . -A "shells.$1" --command "$SHELL"

# Performs all code checks
@fmt: nix lint lua

# Format nix code
@nix:
    treefmt

# Lint nix code
@lint:
    statix check

# Format lua code
@lua:
    stylua .
