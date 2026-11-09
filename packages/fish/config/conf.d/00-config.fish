status is-login; and begin
    # Login shell initialisation
end

status is-interactive; and begin
    # Abbreviations
    abbr --add -- compress tar czf \"tar_name.tar.gz\" \<files\>
    abbr --add -- extract tar xzf \"targz_file\"

    # Aliases
    command -q bat; and alias cat bat
    command -q dev-session; and alias di dev-session
    command -q tmuxp; and alias dots 'tmuxp load -y dotfiles'
    command -q pokefetch; and alias fetch pokefetch
    command -q gitui; and alias gi gitui
    command -q just; and alias j just
    command -q yazi; and alias lf yazi

    if command -q eza
        alias ls eza
        alias la 'eza -a'
        alias ll 'eza -l'
        alias lla 'eza -la'
        alias lt 'eza --tree'
        alias tree 'eza --tree'
    end

    if command -q nvim
        alias vim nvim
        alias vi nvim
    end

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
