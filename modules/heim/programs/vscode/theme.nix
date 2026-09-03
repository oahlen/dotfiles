{ variant }:
with variant;
{
  workbench = {
    "editor.background" = background;
    "editor.foreground" = foreground;
    "editor.lineHighlightBackground" = surface-variant;
    "editorCursor.foreground" = foreground;
    "editor.selectionBackground" = selection.background;
    "editor.selectionHighlightBackground" = selection.highlight;

    "activityBar.background" = background;
    "activityBar.foreground" = foreground;
    "sideBar.background" = background;
    "sideBar.foreground" = foreground;

    "statusBar.background" = statusline.background;
    "statusBar.foreground" = statusline.foreground;
    "statusBar.debuggingBackground" = statusline.accent;

    "titleBar.activeBackground" = background;
    "titleBar.activeForeground" = foreground;

    "tab.activeBackground" = surface-variant;
    "tab.inactiveBackground" = background;

    "focusBorder" = statusline.accent;
    "badge.background" = statusline.accent;

    "menu.background" = background;
    "menu.foreground" = foreground;
    "menu.selectionBackground" = selection.background;
    "menubar.selectionBackground" = selection.background;

    "breadcrumb.background" = background;
    "breadcrumb.foreground" = foreground;
    "editorGroupHeader.tabsBackground" = background;

    "panel.background" = background;
    "panel.border" = surface-variant;
    "panelTitle.activeForeground" = foreground;

    "quickInput.background" = background;
    "quickInput.foreground" = foreground;
    "list.activeSelectionBackground" = selection.background;
    "list.hoverBackground" = surface-variant;
    "dropdown.background" = surface-variant;
    "input.background" = surface-variant;
    "scrollbarSlider.background" = surface-variant;

    "diffEditor.insertedTextBackground" = diff.added_bg;
    "diffEditor.removedTextBackground" = diff.deleted_bg;

    "terminal.background" = background;
    "terminal.foreground" = foreground;
    "terminal.ansiBlack" = black;
    "terminal.ansiRed" = red;
    "terminal.ansiGreen" = green;
    "terminal.ansiYellow" = yellow;
    "terminal.ansiBlue" = blue;
    "terminal.ansiMagenta" = purple;
    "terminal.ansiCyan" = cyan;
    "terminal.ansiWhite" = white;
    "terminal.ansiBrightBlack" = bright-black;
    "terminal.ansiBrightRed" = bright-red;
    "terminal.ansiBrightGreen" = bright-green;
    "terminal.ansiBrightYellow" = bright-yellow;
    "terminal.ansiBrightBlue" = bright-blue;
    "terminal.ansiBrightMagenta" = bright-purple;
    "terminal.ansiBrightCyan" = bright-cyan;
    "terminal.ansiBrightWhite" = bright-white;
  };

  tokenColors = [
    {
      scope = "comment";
      settings.foreground = bright-black;
      settings.fontStyle = "italic";
    }
    {
      scope = "string";
      settings.foreground = green;
    }
    {
      scope = [
        "keyword"
        "keyword.control"
        "storage"
      ];
      settings.foreground = purple;
    }
    {
      scope = [
        "entity.name.function"
        "support.function"
      ];
      settings.foreground = blue;
    }
    {
      scope = [
        "constant.numeric"
        "constant.language"
      ];
      settings.foreground = orange;
    }
    {
      scope = [
        "entity.name.type"
        "support.type"
        "entity.name.class"
      ];
      settings.foreground = cyan;
    }
    {
      scope = [
        "variable.other.property"
        "variable.other.object.property"
        "support.type.property-name"
        "meta.object-literal.key"
      ];
      settings.foreground = foreground;
    }
    {
      scope = "support.type.property-name.json";
      settings.foreground = blue;
    }
    {
      scope = "variable";
      settings.foreground = foreground;
    }
  ];
}
