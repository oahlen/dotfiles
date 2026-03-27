{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "homage";
  version = "1791e58caf9d712bb9d561764665c3a6a992c5b5";

  src = fetchFromGitHub {
    owner = "oahlen";
    repo = "homage";
    rev = version;
    sha256 = "sha256-LCj1ydbCBVMj8EkpFhktQN0vHcOSTXdNI+PA2T3zM0w=";
  };

  cargoHash = "sha256-OVRs48EBgCZcLA/nUXuYcrnzZq+VKDTZAE1yZcO/lLE=";

  meta = {
    description = "Simple and effective dotfiles manager for your home.";
    mainProgram = "homage";
    homepage = "https://github.com/oahlen/homage";
    license = with lib.licenses; [ mit ];
    # maintainers = [];
  };
}
