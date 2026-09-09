# AGENTS.md

Personal Nix dotfiles: NixOS hosts + home-manager-alternative [heim](https://github.com/oahlen/nix-heim) homes.
**No flakes** — pinning via [npins](https://github.com/andir/npins), entry point is `default.nix`.

## Structure

- `default.nix` — top-level, imports `npins` pins, builds `hosts`, `homes`, `packages`, `shells`
- `npins/sources.json` — pinned inputs (nixpkgs, nixos-unstable, nix-heim, NixOS-WSL, ...); edit via `npins add/update`, never by hand
- `hosts/<name>/configuration.nix` — NixOS system config per host (desktop, wsl, xps15)
- `hosts/<name>/home.nix` — heim (home-manager-like) config per host (+ `mac`, home-only)
- `modules/nixos/` — NixOS modules: `features/` (toggleable units), `profiles/` (host classes: desktop/laptop/wsl/work), `services/`
- `modules/heim/` — user-level modules: `features/`, `profiles/`, `programs/` (per-program configs)
- `packages/` — custom package derivations, exposed via overlay `customPackages`
- `sources/` — nvfetcher-managed fetched sources (`generated.nix`/`.json`), separate from npins
- `shells/` — `nix-shell` dev environments (dotnet, java, python, rust, fhs, playground)
- `templates/` — plain config file templates (not Nix)

## Commands (use `just`, see `justfile`)

- `just check <host>` — build a host's system closure without switching
- `just rebuild-boot` / `just rebuild-switch` — apply NixOS config for current hostname
- `just home-switch` / `just home-install` / `just manifest` — apply/build heim home config
- `just build <pkg>` / `just run <pkg>` — build/run from `packages.<pkg>`
- `just shell <name>` — enter a dev shell from `shells/`
- `just update-pins` — `npins update` (bump flake-less inputs)
- `just update-sources` — regenerate `sources/generated.*` via nvfetcher
- `just fmt` — `treefmt` (nix) + `stylua` (lua); `just lint` — `statix check`

## Conventions

- No `flake.nix`/`flake.lock` — all pinning is npins (`npins/sources.json`) + nvfetcher (`sources/generated.json`) for non-nix fetches (e.g. plugins)
- Modules follow the `features` (small toggle) vs `profiles` (composition of features per host role) split — put new host-agnostic options in `features/`, wire them up in a `profiles/*.nix`
- Custom packages go under `packages/<name>/default.nix`, exported via `pkgs.customPackages` (see `packages/default.nix`)
- Run `just fmt` before committing Nix changes
