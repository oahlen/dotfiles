{
  bash,
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

  # Custom copilot sandbox wrapper
  profile = {
    meta.name = "copilot";
    groups.include = [
      "git_config"
      "linux_sysfs_read"
      "linux_temp_read"
      "nix_runtime"
      "system_read_linux_core"
      "system_write_linux"
    ];
    workdir.access = "readwrite";
    filesystem = {
      allow = [
        "~/.cache/copilot"
        "~/.copilot"
        "~/.local/share/dotnet" # NuGet etc.
      ];
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

    ${lib.getExe nono} run --profile ${file} --allow-cwd -- ${lib.getExe github-copilot-cli} "$@"
  '';

in
symlinkJoin {
  name = "copilot";
  paths = [
    bash # Make sure bash is available
    github-copilot-cli
    nono # For debugging
    sandbox
  ];
}
