{
  lib,
  pkgs-unstable,
  symlinkJoin,
  writeShellScriptBin,
  writeText,
  ...
}:
let
  inherit (pkgs-unstable)
    goose-cli
    nono
    ;

  dotnetDevDirs = [
    "~/.local/share/AvaloniaUI"
    "~/.local/share/dotnet" # NuGet etc.
  ];

  # Custom goose sandbox wrapper
  # Policy reference https://github.com/nolabs-ai/nono/blob/main/crates/nono-cli/data/policy.json
  profile = {
    meta.name = "goose-cli";
    groups.include = [
      "git_config"
      "linux_runtime_state"
      "linux_sysfs_read"
      "linux_temp_read"
      "nix_runtime"
      "node_runtime"
      "python_runtime"
      "rust_runtime"
      "system_read_linux_core"
      "system_write_linux"
    ];
    workdir.access = "readwrite";
    filesystem = {
      allow = [
        "~/.cache/goose"
        "~/.cache/nix"
        "~/.config/goose"
        "~/.local/share/goose"
        "~/.local/share/Olink"
        "~/.local/state/goose"
      ]
      ++ dotnetDevDirs;
      allow_file = [
        "/dev/ptmx"
      ];
      read = [
        "~/.agents"
        "~/dotfiles" # Some config files link back here
      ];
      write = [ ];
    };
    network.block = false;
  };

  file = writeText "profile.json" (builtins.toJSON profile);

  sandbox = writeShellScriptBin "goose-cli-sandbox" ''
    # Remove sensitive variables
    unset $(env | grep -o '^OP_[^=]*')

    # Create goose folders before entering the sandbox
    mkdir -p "$HOME/.cache/goose" "$HOME/.config/goose" "$HOME/.local/share/goose" "$HOME/.local/state/goose"

    ${lib.getExe nono} run --profile ${file} --allow-cwd -- ${lib.getExe goose-cli} "$@"
  '';

in
symlinkJoin {
  name = "goose-cli";
  paths = [
    goose-cli
    nono # For debugging
    sandbox
  ];
}
