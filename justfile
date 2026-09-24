set positional-arguments

# Show available commands
help:
    @just --list --unsorted

# Enter the bootstrap shell environment
@bootstrap:
    nix-shell

# Open the pinned nixpkgs release page
@nixpkgs:
    url=$(jq -r '.pins.nixpkgs.url' npins/sources.json); xdg-open "${url%/*}"

# Update pins to the latest version
@update-pins:
    npins update

# Update sources to the latest version
@update-sources:
    nvfetcher -o sources
    jq '.' sources/generated.json | sponge sources/generated.json

# Evaluate the specified host configuration without building
@check-host host:
    nix eval --raw -f . "hosts.$1.config.system.build.toplevel.drvPath"

# Evaluate the specified home configuration without building
@check-home home:
    nix eval --raw -f . "homes.$1.environment.drvPath"

# Evaluate every host configuration without building
@check-hosts:
    nix eval -f . --json --apply 'builtins.mapAttrs (_: h: h.config.system.build.toplevel.drvPath)' hosts

# Evaluate every home configuration without building
@check-homes:
    nix eval -f . --json --apply 'builtins.mapAttrs (_: h: h.environment.drvPath)' homes

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
@checks: fmt-nix lint-nix fmt-lua

# Format nix code
@fmt-nix:
    treefmt

# Lint nix code
@lint-nix:
    statix check

# Format lua code
@fmt-lua:
    stylua .
