status is-login; and begin
    # Login shell initialisation
end

status is-interactive; and begin
    # Abbreviations
    abbr --add -- bash /run/current-system/sw/bin/bash
    abbr --add -- extract tar xzf \"targz_file\"
    abbr --add -- compress tar czf \"tar_name.tar.gz\" \<files\>

    # Aliases
    alias cat bat
    alias di dev-session
    alias gi gitui
    alias la 'eza -a'
    alias lf yazi
    alias ll 'eza -l'
    alias lla 'eza -la'
    alias ls eza
    alias lt 'eza --tree'
    alias dot-edit 'tmuxp load -y dotfiles'
    alias nix-edit 'tmuxp load -y nix-config'
    alias note-edit 'tmuxp load -y notes'
    alias tree 'eza --tree'
    alias vi nvim
    alias vim nvim

    # Interactive shell initialisation
    fzf --fish | source

    set fish_greeting

    # For tmux
    set -gx SHELL /run/current-system/sw/bin/fish

    fish_vi_key_bindings
    set fish_vi_force_cursor
    set fish_cursor_default block
    set fish_cursor_insert line

    # The superior note taking system
    bind \cn 'nvim $HOME/notes.txt'

    batman --export-env | source

    zoxide init fish | source

    direnv hook fish | source
end
