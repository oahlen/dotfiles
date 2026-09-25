{ ... }:
let
  windowsUser = "oscar.ahlen"; # Change to correct Windows username
in
{
  profiles = {
    wsl.enable = true;
  };

  programs = {
    vscode = {
      enable = true;
      installPackage = false; # VS Code runs on Windows via Remote-WSL
    };
  };

  activationHooks = [
    ''
      mkdir -p "/mnt/c/Users/${windowsUser}/AppData/Roaming/Code/User"
      cp "$HOME/.config/Code/User/settings.json" "/mnt/c/Users/${windowsUser}/AppData/Roaming/Code/User/settings.json"
    ''
  ];
}
