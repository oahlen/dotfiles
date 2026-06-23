function nix-kernels
    set branch (if test (count $argv) -gt 0; echo $argv[1]; else; echo master; end)
    printf "Displaying kernel versions from \033[1;35m%s\033[0m\n" $branch

    set url "https://raw.githubusercontent.com/NixOS/nixpkgs/refs/heads/$branch/pkgs/os-specific/linux/kernel/kernels-org.json"
    curl -s $url | jq -r 'to_entries[] | "\u001b[1m\(.key):\u001b[0m \(.value.version)"'

    set zen_url "https://raw.githubusercontent.com/NixOS/nixpkgs/refs/heads/$branch/pkgs/os-specific/linux/kernel/zen-kernels.nix"
    set zen_version (curl -s $zen_url | grep -o 'version = "[^"]*"' | grep -o '"[^"]*"' | tr -d '"')
    printf "\033[1mZen:\033[0m %s\n" $zen_version
end
