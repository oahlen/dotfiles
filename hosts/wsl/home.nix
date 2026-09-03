{
  pkgs,
  ...
}:
let
  windowsUser = "oscar.ahlen";
in
{
  profiles = {
    work.enable = true;
    wsl.enable = true;
  };

  features = {
    development.enable = true;
  };

  programs = {
    one-password.enable = true;
    vscode = {
      enable = true;
      installPackage = false; # VS Code runs on Windows via Remote-WSL
    };
  };

  home = {
    packages = with pkgs; [
      awscli2
      duckdb
      gh
      pqrs
      typst
    ];

    sessionVariables = {
      AWS_CONFIG_FILE = "$HOME/.config/aws/config";
      AWS_SHARED_CREDENTIALS_FILE = "$HOME/.config/aws/credentials";
    };
  };

  activationHooks = [
    ''
      mkdir -p "/mnt/c/Users/${windowsUser}/AppData/Roaming/Code/User"
      cp "$HOME/.config/Code/User/settings.json" "/mnt/c/Users/${windowsUser}/AppData/Roaming/Code/User/settings.json"
    ''
  ];
}
