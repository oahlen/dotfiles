function prune-branches
    git fetch --prune
    git branch | grep -v main | xargs git branch -D
end
