function spawn --description "Executes a completely detached process"
    if test (count $argv) -eq 0
        echo "Usage: spawn <command> [args...]" >&2
        return 1
    end

    nohup $argv &>/dev/null &
    disown
end
