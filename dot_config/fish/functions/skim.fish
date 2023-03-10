function skim --description "Skim through files blazingly fast!"
    fzf --preview="bat {} --color=always --style=numbers" | xargs -r bat
end
