require("agentic").setup({
    -- Set AGENTIC_NVIM_PROVIDER to use another provider, e.g. "claude-acp"
    provider = os.getenv("AGENTIC_NVIM_PROVIDER") or "goose-acp",
    acp_providers = {
        ["goose-acp"] = {
            command = "goose-cli-sandbox",
        },
    },
    diagnostic_icons = {
        error = "󰅚 ",
        warn = "󰀪 ",
        info = "󰋽 ",
        hint = "󰌶 ",
    },
})

vim.keymap.set("n", "<leader>aa", function()
    require("agentic").toggle()
end, { desc = "Toggle Agentic Chat" })

vim.keymap.set("n", "<leader>an", function()
    require("agentic").new_session()
end, { desc = "New Agentic Session" })

vim.keymap.set("n", "<leader>ar", function()
    require("agentic").restore_session()
end, { desc = "Restore Agentic Session" })

vim.keymap.set("n", "<leader>af", function()
    require("agentic").add_file()
end, { desc = "Add File to Context" })

vim.keymap.set("v", "<leader>as", function()
    require("agentic").add_selection()
end, { desc = "Add Selection to Context" })

vim.keymap.set("n", "<leader>ax", function()
    require("agentic").stop_generation()
end, { desc = "Stop Agentic Generation" })
