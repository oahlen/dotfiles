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

  dotnetDirs = [
    "~/.local/share/AvaloniaUI"
    "~/.local/share/dotnet" # NuGet etc.
  ];

  gooseDirs = [
    "~/.cache/goose"
    "~/.config/goose"
    "~/.local/share/goose"
    "~/.local/state/goose"
  ];

  nixDirs = [
    "~/.cache/nix" # For fetching tarballs etc.
  ];

  rtkDirs = [
    "~/.config/rtk"
    "~/.local/share/rtk"
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
        "~/.local/share/Olink"
      ]
      ++ dotnetDirs
      ++ gooseDirs
      ++ nixDirs
      ++ rtkDirs;
      allow_file = [
        "/dev/ptmx"
      ];
      read = [
        "~/.agents"
        "~/dotfiles" # Some config files can link back here
      ];
      write = [ ];
    };
    network.block = false;
  };

  file = writeText "profile.json" (builtins.toJSON profile);

  # Hooking up goose to GHE
  # export GITHUB_COPILOT_HOST="your-company.ghe.com"
  # Use the bare host only - no https:// scheme and no trailing slash.
  sandbox = writeShellScriptBin "goose-cli-sandbox" ''
    # Remove sensitive variables
    unset $(env | grep -o '^OP_[^=]*')

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
