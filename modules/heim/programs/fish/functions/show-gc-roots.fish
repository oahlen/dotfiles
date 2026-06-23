function shell --description "Prints all current GC roots"
    nix-store --gc --print-roots | rg -v '\{censored\}'
end
