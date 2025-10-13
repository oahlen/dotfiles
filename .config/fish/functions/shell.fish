function shell --argument-names name --description "Enters the dev shell of the given name"
    if not test -n "$FLAKE"
        echo "\$FLAKE variable must be set"
        return
    end

    if not test -n "$name"
        echo "Shell name must be provided"
        return
    end

    nix develop "$FLAKE#$name" -c "$SHELL"
end
