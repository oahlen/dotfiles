function shell --description "Spawns a nix shell with the given packages"
    if test (count $argv) -eq 0
        echo "Usage: shell <package> [packages...]" >&2
        return 1
    end

    nix-shell -p $argv --command "export NIX_SHELL='Ephemeral Shell' && fish"
end
