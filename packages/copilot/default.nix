{
  github-copilot-cli,
  lib,
  nono,
  symlinkJoin,
  writeShellScriptBin,
  writeText,
  ...
}:
let
  # Custom copilot sandbox wrapper
  profile = {
    meta.name = "copilot";
    groups.include = [
      "git_config"
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
        "~/.local/share/rtk" # Write to rtk history
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
    github-copilot-cli
    nono # For debugging
    sandbox
  ];
}
