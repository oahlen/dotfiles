function switch-branch
    set branch (git branch --format '%(refname:short)' | fzf --prompt 'Switch branch: ')

    if test -n "$branch"
        git switch $branch
    end
end
