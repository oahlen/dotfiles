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
      "user_caches_linux"
      "user_tools"
    ];
    workdir.access = "readwrite";
    filesystem = {
      allow = [
        "~/.local/share/cargo"
        "~/.local/share/dotnet"
        "~/.local/share/goose"
        "~/.local/state/goose"
      ];
      allow_file = [
        "/dev/ptmx"
      ];
      read = [
        "~/.agents"
        "~/.config/goose"
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
    export GOOSE_MODE="''${GOOSE_MODE:-auto}"

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
