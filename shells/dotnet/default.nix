{ pkgs }:
let
  combined =
    with pkgs.dotnetCorePackages;
    combinePackages [
      sdk_8_0
      sdk_10_0
    ];

  quick-format = pkgs.writeShellApplication {
    name = "quick-format";
    runtimeInputs = [
      combined
      pkgs.gitMinimal
      pkgs.gnugrep
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
  };
in
pkgs.mkShell {
  NIX_SHELL = "DotNet";
  ASPNETCORE_ENVIRONMENT = "Development";
  DOTNET_ROOT = "${combined}/share/dotnet/";

  LD_LIBRARY_PATH =
    with pkgs;
    lib.makeLibraryPath [
      # For GUI based applications
      fontconfig
      libGL
      libICE
      libSM
      libX11
      libXcursor
      libXi
      libxkbcommon
      libXrandr
      wayland

      # For certain tools like Microsoft sbom tool
      mono

      # Needed by GitVersion
      openssl
    ];

  packages = with pkgs; [
    combined
    csharp-ls # omnisharp-roslyn
    netcoredbg
    openssl
    quick-format
  ];
}
