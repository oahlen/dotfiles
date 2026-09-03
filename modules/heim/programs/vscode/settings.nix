let
  fontFamily = "'JetBrainsMono Nerd Font', monospace";
in
{
  "editor.fontFamily" = fontFamily;
  "editor.lineNumbers" = "relative";
  "editor.cursorSurroundingLines" = 10;

  "terminal.integrated.fontFamily" = fontFamily;

  "vim.leader" = "<space>";
  "vim.hlsearch" = true;
  "vim.ignorecase" = true;
  "vim.smartcase" = true;

  "vim.normalModeKeyBindingsNonRecursive" = [
    {
      before = [ "Y" ];
      after = [
        "y"
        "$"
      ];
    }
    {
      before = [ "<C-h>" ];
      commands = [ "workbench.action.navigateLeft" ];
    }
    {
      before = [ "<C-j>" ];
      commands = [ "workbench.action.navigateDown" ];
    }
    {
      before = [ "<C-k>" ];
      commands = [ "workbench.action.navigateUp" ];
    }
    {
      before = [ "<C-l>" ];
      commands = [ "workbench.action.navigateRight" ];
    }
    {
      before = [
        "<C-d>"
      ];
      after = [
        "<C-d>"
        "z"
        "z"
      ];
    }
    {
      before = [
        "<C-u>"
      ];
      after = [
        "<C-u>"
        "z"
        "z"
      ];
    }
    {
      before = [ "n" ];
      after = [
        "n"
        "z"
        "z"
        "z"
        "v"
      ];
    }
    {
      before = [ "N" ];
      after = [
        "N"
        "z"
        "z"
        "z"
        "v"
      ];
    }
    {
      before = [ "<Esc>" ];
      commands = [ ":nohl" ];
    }
    {
      before = [ "H" ];
      commands = [ "workbench.action.previousEditor" ];
    }
    {
      before = [ "L" ];
      commands = [ "workbench.action.nextEditor" ];
    }
    {
      before = [
        "<leader>"
        "q"
      ];
      commands = [ "workbench.action.closeActiveEditor" ];
    }
    {
      before = [
        "<leader>"
        "f"
      ];
      commands = [ "workbench.action.quickOpen" ];
    }
    {
      before = [
        "<leader>"
        "g"
      ];
      commands = [ "workbench.action.findInFiles" ];
    }
    {
      before = [
        "<leader>"
        "b"
      ];
      commands = [ "workbench.action.openRecent" ];
    }
    {
      before = [
        "<leader>"
        "e"
      ];
      commands = [ "workbench.files.action.focusFilesExplorer" ];
    }
    {
      before = [
        "<leader>"
        "E"
      ];
      commands = [ "workbench.files.action.showActiveFileInExplorer" ];
    }
    {
      before = [ "gd" ];
      commands = [ "editor.action.revealDefinition" ];
    }
    {
      before = [ "gri" ];
      commands = [ "editor.action.goToImplementation" ];
    }
    {
      before = [ "grr" ];
      commands = [ "editor.action.goToReferences" ];
    }
    {
      before = [ "grn" ];
      commands = [ "editor.action.rename" ];
    }
    {
      before = [ "gn" ];
      commands = [ "editor.action.marker.next" ];
    }
    {
      before = [ "K" ];
      commands = [ "editor.action.showHover" ];
    }
    {
      before = [
        "="
        "="
      ];
      commands = [ "editor.action.formatSelection" ];
    }
    {
      before = [ "gj" ];
      commands = [ "editor.action.dirtydiff.next" ];
    }
    {
      before = [ "gk" ];
      commands = [ "editor.action.dirtydiff.previous" ];
    }
  ];

  "vim.visualModeKeyBindingsNonRecursive" = [
    {
      before = [ "<" ];
      after = [
        "<"
        "g"
        "v"
      ];
    }
    {
      before = [ ">" ];
      after = [
        ">"
        "g"
        "v"
      ];
    }
    {
      before = [ "gc" ];
      commands = [ "editor.action.commentLine" ];
    }
    {
      before = [ "gb" ];
      commands = [ "editor.action.blockComment" ];
    }
  ];
}
