-- Commands
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end
})

vim.api.nvim_create_user_command('ApplyDotfiles', function(_)
    if os.execute("chezmoi apply --force") == 0 then
        print("Dotfiles updated")
    else
        print("Dotfiles could not be updated")
    end
end, {})
