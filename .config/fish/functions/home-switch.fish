function home-switch --description "Rebuilds the Home configuration"
    echo "Building home-manager configuration for $(whoami)@$(hostname)"
    home-manager switch --flake $FLAKE#$(whoami)@$(hostname)
end
