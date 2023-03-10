if status is-interactive
    # Disable fish greeting
    set fish_greeting

    # Zoxide
    zoxide init fish | source

    # Pyenv
    # set -gx PATH $PYENV_ROOT/bin:$PATH
    # pyenv init --path | source
end
