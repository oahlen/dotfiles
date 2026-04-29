set positional-arguments

# Show available commands
help:
    @just --list --unsorted

# Enter the bootstrap shell environment
@bootstrap:
    nix-shell

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
@rebuild-boot:
    nixos-rebuild boot -f . -A "hosts.$(hostname)" --quiet --no-reexec --sudo

# Run nixos-rebuild switch for the current host
@rebuild-switch:
    nixos-rebuild switch -f . -A "hosts.$(hostname)" --quiet --no-reexec --sudo

# Installs the home configuration for the current host
@home-install:
    nix run -f . "homes.$(hostname).install"

# Switches to the home configuration for the current host
@home-switch:
    heim-switch . "homes.$(hostname)"

# Build the home configuration (manifest) for the current host
@manifest:
    nix build -f . "homes.$(hostname).manifest"

# Build the specified package
@build package:
    nix build -f . "packages.$1"

# Run the specified package
@run package:
    nix run -f . "packages.$1"

# Enter the specified shell
@shell name:
    nix-shell default.nix -A "shells.$1" --command "$SHELL"

# Enter the playground shell
@playground:
    nix-shell default.nix -A "shells.playground" --command "$SHELL"

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
