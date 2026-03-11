return {
    "fzf-lua",
    lazy = false,
    keys = {
        { "<leader><leader>", "<CMD>FzfLua<CR>", desc = "Open picker" },
        { "<leader>f", "<CMD>FzfLua files<CR>", desc = "Find files" },
        { "<leader>g", "<CMD>FzfLua live_grep<CR>", desc = "Live grep" },
        { "<leader>b", "<CMD>FzfLua buffers<CR>", desc = "List open buffers" },
        { "<leader>r", "<CMD>FzfLua resume<CR>", desc = "Resume picker" },
    },
    after = function()
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
    end,
}
