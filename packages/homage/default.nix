{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "homage";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "oahlen";
    repo = "homage";
    rev = version;
    sha256 = "sha256-DRidkSexUOgQn5jCK3yUP5we63+dJoQGzRYYbcq1KNM=";
  };

  cargoHash = "sha256-oykux000pWk6e6XNy2UQPCgBwfiXyTKj1Kl2HuQIL3g=";

  meta = with lib; {
    description = "Simple and effective dotfiles manager for your home.";
    mainProgram = "homage";
    homepage = "https://github.com/oahlen/homage";
    license = with licenses; [ mit ];
    # maintainers = [];
  };
}
