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

        vim.keymap.set("n", "gj", "<CMD>Gitsigns next_hunk<CR>", { desc = "Goto Next Git Change" })
        vim.keymap.set("n", "gk", "<CMD>Gitsigns prev_hunk<CR>", { desc = "Goto Previous Git Change" })
    end,
}
