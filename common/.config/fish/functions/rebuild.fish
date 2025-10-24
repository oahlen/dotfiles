function rebuild --argument-names argument --description "Rebuilds the NixOS configuration"
    if not test -n "$argument"
        nixos-rebuild --help
        return
    end

    nixos-rebuild $argument --sudo --flake $FLAKE
end
