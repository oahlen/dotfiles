status is-login; and begin
    # Login shell initialisation
end

status is-interactive; and begin
    # Abbreviations
    abbr --add -- compress tar czf \"tar_name.tar.gz\" \<files\>
    abbr --add -- extract tar xzf \"targz_file\"

    # Aliases
    alias cat bat
    alias di dev-session
    alias dots 'tmuxp load -y dotfiles'
    alias fetch pokefetch
    alias gi gitui
    alias j just
    alias la 'eza -a'
    alias lf yazi
    alias lla 'eza -la'
    alias ll 'eza -l'
    alias ls eza
    alias lt 'eza --tree'
    alias tree 'eza --tree'
    alias vim nvim
    alias vi nvim

    # Interactive shell initialisation
    type -q batman; and batman --export-env | source
    type -q direnv; and direnv hook fish | source
    type -q fzf; and fzf --fish | source

    set fish_greeting

    # For tmux
    set -gx SHELL (command -v fish)

    fish_vi_key_bindings
    set fish_vi_force_cursor
    set fish_cursor_default block
    set fish_cursor_insert line
end
