vim.api.nvim_create_user_command('ApplyDotfiles', function(_)
    if os.execute("chezmoi apply --force") == 0 then
        print("Dotfiles updated")
    else
        print("Dotfiles could not be updated")
    end
end, {})
