function vio
    fzf --preview='bat {} --color=always --style=numbers' | xargs -r nvim
end
