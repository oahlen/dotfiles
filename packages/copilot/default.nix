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
    github-copilot-cli
    nono
    ;

  defaultModel = "claude-sonnet-5";

  dotnetDevDirs = [
    "~/.local/share/AvaloniaUI"
    "~/.local/share/dotnet" # NuGet etc.
  ];

  # Custom copilot sandbox wrapper
  # Policy reference https://github.com/nolabs-ai/nono/blob/main/crates/nono-cli/data/policy.json
  profile = {
    meta.name = "copilot";
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
        "~/.cache/copilot"
        "~/.copilot"
        "~/.local/share/Olink"
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

  sandbox = writeShellScriptBin "copilot-sandbox" ''
    # Remove sensitive variables
    unset $(env | grep -o '^OP_[^=]*')

    # Enable OTEL export for ccusage
    export COPILOT_OTEL_ENABLED=true
    export COPILOT_OTEL_EXPORTER_TYPE=file
    mkdir -p "$HOME/.copilot/otel"
    export COPILOT_OTEL_FILE_EXPORTER_PATH="$HOME/.copilot/otel/copilot-otel-$(date +%Y%m%d-%H%M%S).jsonl"

    ${lib.getExe nono} run --profile ${file} --allow-cwd -- ${lib.getExe github-copilot-cli} --model ${defaultModel} "$@"
  '';

in
symlinkJoin {
  name = "copilot";
  paths = [
    github-copilot-cli
    nono # For debugging
    sandbox
  ];
}
