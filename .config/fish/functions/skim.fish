function skim
    fzf --preview='bat {} --color=always --style=numbers' | xargs -r bat
end
