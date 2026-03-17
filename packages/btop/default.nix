{
  bottom,
  writeShellScriptBin,
  writeText,
}:
# Process viewer using a wrapped bottom
let
  config = writeText "btop.toml" ''
    [flags]
    group_processes = true
    process_memory_as_value = true

    [[row]]
    ratio = 100
    [[row.child]]
    type = "proc"
  '';
in
writeShellScriptBin "btop" ''
  ${bottom}/bin/btm --config_location ${config}
''
