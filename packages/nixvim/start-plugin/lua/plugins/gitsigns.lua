require("gitsigns").setup({
    on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        vim.keymap.set("n", "<leader>hb", function()
            gitsigns.blame_line({ full = true })
        end, { buffer = bufnr })

        vim.keymap.set("n", "<leader>hd", gitsigns.diffthis, { buffer = bufnr })

        vim.keymap.set("n", "<leader>hD", function()
            gitsigns.diffthis("~")
        end, { buffer = bufnr })
    end,
})
