function vio --description "Skim through files and open them in nvim"
    fzf --preview="bat {} --color=always --style=numbers" | xargs -r nvim
end
