{ ... }:
let
  windowsUser = "oscar.ahlen"; # Change to correct Windows username
in
{
  profiles = {
    work.enable = true;
    wsl.enable = true; # Would never use WSL outside of work ...
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
