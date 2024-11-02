if status is-interactive
    # Disable fish greeting
    set fish_greeting

    fish_vi_key_bindings
    set fish_vi_force_cursor
    set fish_cursor_default block
    set fish_cursor_insert line

    # Zoxide
    zoxide init fish | source
end
