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
      "nix_runtime"
      "system_read_linux_core"
      "system_write_linux"
    ];
    workdir.access = "readwrite";
    filesystem = {
      allow = [
        "~/.cache/copilot"
        "~/.copilot"
      ];
      allow_file = [
        "/dev/ptmx"
      ];
      read = [
        "~/.agents"
      ];
      write = [ ];
    };
    network.block = false;
  };

  file = writeText "profile.json" (builtins.toJSON profile);

  sandbox = writeShellScriptBin "copilot-sandbox" ''
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
