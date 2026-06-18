{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.gitui;

  key_bindings = ''
    (
        open_help: Some(( code: F(1), modifiers: "")),

        move_left: Some(( code: Char('h'), modifiers: "")),
        move_right: Some(( code: Char('l'), modifiers: "")),
        move_up: Some(( code: Char('k'), modifiers: "")),
        move_down: Some(( code: Char('j'), modifiers: "")),

        popup_up: Some(( code: Char('p'), modifiers: "CONTROL")),
        popup_down: Some(( code: Char('n'), modifiers: "CONTROL")),
        page_up: Some(( code: Char('b'), modifiers: "CONTROL")),
        page_down: Some(( code: Char('f'), modifiers: "CONTROL")),
        home: Some(( code: Char('g'), modifiers: "")),
        end: Some(( code: Char('G'), modifiers: "SHIFT")),
        shift_up: Some(( code: Char('K'), modifiers: "SHIFT")),
        shift_down: Some(( code: Char('J'), modifiers: "SHIFT")),

        edit_file: Some(( code: Char('I'), modifiers: "SHIFT")),

        status_reset_item: Some(( code: Char('U'), modifiers: "SHIFT")),

        diff_reset_lines: Some(( code: Char('u'), modifiers: "")),
        diff_stage_lines: Some(( code: Char('s'), modifiers: "")),

        stashing_save: Some(( code: Char('w'), modifiers: "")),
        stashing_toggle_index: Some(( code: Char('m'), modifiers: "")),

        stash_open: Some(( code: Char('l'), modifiers: "")),

        abort_merge: Some(( code: Char('M'), modifiers: "SHIFT")),
    )
  '';

  theme = ''
    (
        use_selection_fg: Some(false),
        selected_tab: Some("White"),
        command_fg: Some("Reset"),
        selection_bg: Some("Black"),
        selection_fg: Some("Reset"),
        cmdbar_bg: Some("Black"),
        cmdbar_extra_lines_bg: Some("Black"),
        disabled_fg: Some("DarkGray"),
        diff_line_add: Some("Green"),
        diff_line_delete: Some("Red"),
        diff_file_added: Some("LightGreen"),
        diff_file_removed: Some("LightRed"),
        diff_file_moved: Some("LightMagenta"),
        diff_file_modified: Some("Yellow"),
        commit_hash: Some("Magenta"),
        commit_time: Some("Cyan"),
        commit_author: Some("Green"),
        danger_fg: Some("LightRed"),
        push_gauge_bg: Some("Blue"),
        push_gauge_fg: Some("Black"),
        tag_fg: Some("Yellow"),
        branch_fg: Some("LightMagenta")
    )
  '';
in
{
  options.programs.gitui.enable = lib.mkEnableOption "gitui.";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.gitui ];

    xdg.config.files = {
      "gitui/key_bindings.ron".text = key_bindings;
      "gitui/theme.ron".text = theme;
    };
  };
}
