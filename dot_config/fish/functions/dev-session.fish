function dev-session --argument-names "session" --description "Create a tmux dev session and attach to it"
    if not test -n "$session"
        echo "Session name must be provided"
        return
    end

    set -gx TMUX_SESSION $session
    tmuxp load -y dev-session
end
