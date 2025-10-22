export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_PUBLICSHARE_DIR="$HOME/Public"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_TEMPLATES_DIR="$HOME/Templates"
export XDG_VIDEOS_DIR="$HOME/Videos"

export XCURSOR_SIZE=24
export XCURSOR_THEME="Adwaita"

export AWS_CONFIG_FILE="$XDG_CONFIG_HOME/aws/config"
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME/aws/credentials"
export CALCHISTFILE="$XDG_CACHE_HOME/calc_history"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export COLORTERM="truecolor"
export DOTNET_CLI_HOME="$XDG_DATA_HOME/dotnet"
export LESSHISTFILE="$XDG_DATA_HOME/less/history"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/ripgreprc"

export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow"
export FZF_DEFAULT_OPTS="--layout=reverse --height=40% --scrollbar '▌' --color bg+:0,border:7,fg+:15,gutter:0,header:4,hl:3,hl+:3,info:8,marker:6,pointer:3,prompt:2,scrollbar:8,separator:8,spinner:5"
export _ZO_FZF_OPTS="$FZF_DEFAULT_OPTS";
export JQ_COLORS="1;33:0;33:0;33:0;33:0;32:0;37:0;37:1;34"

export PATH="$XDG_CONFIG_HOME/scripts:$XDG_DATA_HOME/dotnet/tools:$XDG_DATA_HOME/cargo/bin${PATH:+:}$PATH"
