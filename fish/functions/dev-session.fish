function dev-session --argument-names session --description "Create a tmux dev session and attach to it"
    set workdir $pwd
    set dir (fd --type d | fzf)

    if not test $dir || not test -d $dir
        return
    end

    set name (string replace '.' '-' (basename $dir))

    cd $dir
    tmuxp load -y dev-session -s $name
    cd $workdir
end
