function packages --argument-names "input" --description "List and search through installed packages"
    if test -n "$input" && test "$input" = "--explicit"
        pacman -Qe | fzf --preview "pacman -Qi {1}"
    else
        pacman -Qq | fzf --preview "pacman -Qi {1}"
    end
end
