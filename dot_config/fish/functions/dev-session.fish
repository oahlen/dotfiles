function dev-session --argument-names "session" --description "Create a tmux dev session and attach to it"
    if not test -n "$session"
        echo "Session name must be provided"
        return
    end

    tmux new-session -d -s $session
    tmux new-window -t $session:2 -n "Git"
    tmux new-window -t $session:3 -n "Terminal"

    tmux rename-window -t $session:1 "Code"

    tmux split-window -t $session:Terminal -h

    tmux selectw -t $session:Code
    tmux selectp -t 0

    tmux a -t $session
end
