{ pkgs }:
let
  combined =
    with pkgs.dotnetCorePackages;
    combinePackages [
      sdk_8_0
      sdk_10_0
    ];
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
      libxkbcommon
      wayland
      xorg.libICE
      xorg.libSM
      xorg.libX11
      xorg.libXcursor
      xorg.libXi
      xorg.libXrandr

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
  ];
}
