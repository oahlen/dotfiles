return {
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup {
                check_ts = true,
                ts_config = {},
                disable_filetype = { "TelescopePrompt", "vim" },
                enable_check_bracket_line = false,
                ignored_next_char = "[%w%.#]"
            }

            require("cmp").event:on(
                "confirm_done",
                require("nvim-autopairs.completion.cmp").on_confirm_done()
            )
        end
    }
}
