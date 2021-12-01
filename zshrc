export HISTFILE=~/.zhistory
export HISTSIZE=10000
export SAVEHIST=10000

bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "\e[3~" delete-char

autoload -Uz compinit && compinit

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

eval "$(starship init zsh)"

[[ -f ~/.aliases ]] && . ~/.aliases
