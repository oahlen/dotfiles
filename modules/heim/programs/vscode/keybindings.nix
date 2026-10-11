[
  {
    key = "ctrl+l";
    command = "workbench.action.focusActiveEditorGroup";
    when = "filesExplorerFocus && !inputFocus";
  }
  {
    key = "ctrl+j";
    command = "workbench.action.quickOpenSelectNext";
    when = "inQuickOpen";
  }
  {
    key = "ctrl+k";
    command = "workbench.action.quickOpenSelectPrevious";
    when = "inQuickOpen";
  }
  {
    key = "ctrl+j";
    command = "search.action.focusSearchList";
    when = "searchViewletFocus && inputFocus && hasSearchResult";
  }
  {
    key = "ctrl+j";
    command = "list.focusDown";
    when = "searchViewletFocus && listFocus && !inputFocus";
  }
  {
    key = "ctrl+k";
    command = "list.focusUp";
    when = "searchViewletFocus && listFocus && !inputFocus";
  }
]
