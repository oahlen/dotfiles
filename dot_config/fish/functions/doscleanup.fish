function doscleanup --description "Perform dos2unix conversion recursively in the current directory"
    fd . --type f --print0 | xargs -0 dos2unix
end
