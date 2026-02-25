local fzf_lua = require("fzf-lua")

fzf_lua.setup({
    winopts = {
        backdrop = 100,
        preview = {
            delay = 50,
        },
    },
    fzf_opts = {
        ["--layout"] = "default",
    },
    fzf_colors = {
        true,
        ["hl"] = { "fg", { "Constant" } },
        ["bg+"] = { "bg", { "Visual", "Normal" } },
        ["hl+"] = { "fg", { "Constant" } },
        ["info"] = { "fg", { "LineNr" } },
    },
    grep = {
        RIPGREP_CONFIG_PATH = vim.env.RIPGREP_CONFIG_PATH,
        hidden = true,
    },
})

fzf_lua.register_ui_select()

vim.keymap.set("n", "<leader><space>", "<CMD>FzfLua<CR>", { desc = "Open picker" })
vim.keymap.set("n", "<leader>f", "<CMD>FzfLua files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>g", "<CMD>FzfLua live_grep<CR>", { desc = "Live grep" })
vim.keymap.set("n", "<leader>b", "<CMD>FzfLua buffers<CR>", { desc = "List open buffers" })
vim.keymap.set("n", "<leader>rp", "<CMD>FzfLua resume<CR>", { desc = "Resume picker" })
