return {
    "gitsigns",
    event = "BufEnter",
    after = function()
        require("gitsigns").setup({
            on_attach = function(bufnr)
                local gitsigns = require("gitsigns")

                vim.keymap.set("n", "<leader>hb", function()
                    gitsigns.blame_line({ full = true })
                end, { desc = "Blame Line", buffer = bufnr })

                vim.keymap.set("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff This", buffer = bufnr })

                vim.keymap.set("n", "<leader>hD", function()
                    gitsigns.diffthis("~")
                end, { desc = "Diff This (~)", buffer = bufnr })
            end,
        })
    end,
}
