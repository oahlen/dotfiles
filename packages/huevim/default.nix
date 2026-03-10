{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "huevim";
  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "oahlen";
    repo = "huevim";
    rev = version;
    sha256 = "sha256-BryjhKAG6nVGpeaCWV686RpWv4xgHTjg3etsMEMua9w=";
  };

  cargoHash = "sha256-ttsDiIFW4VSw12/eGdNE6QV4hgFJpUI4zpoZzQuc+CQ=";

  meta = {
    description = "Neovim lua color scheme generator written in Rust.";
    mainProgram = "huevim";
    homepage = "https://github.com/oahlen/huevim";
    license = with lib.licenses; [ mit ];
    # maintainers = [];
  };
}
