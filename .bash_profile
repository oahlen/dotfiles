# Include .profile if it exists
[[ -f ~/.profile ]] && . "$HOME/.profile"

# Include .bashrc if it exists
[[ -f ~/.bashrc ]] && . "$HOME/.bashrc"
