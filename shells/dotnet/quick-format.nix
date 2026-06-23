{
  combined,
  gitMinimal,
  gnugrep,
  writeShellApplication,
}:
writeShellApplication {
  name = "quick-format";

  runtimeInputs = [
    combined
    gitMinimal
    gnugrep
  ];

  text = ''
    FILES=$(git diff HEAD --relative --name-only --diff-filter=ACM | grep "\.cs\$" || true)

    if [ -z "$FILES" ]; then
        echo "No files to format"
        exit 0
    fi

    echo "Formatting changed files ..."

    # Save and change IFS to handle filenames with spaces
    OLDIFS=$IFS
    IFS=$'\n'

    CMD="dotnet format --no-restore --include $(echo "$FILES" | tr '\n' ' ')"

    # Restore IFS
    IFS=$OLDIFS

    exec $CMD
  '';
}
