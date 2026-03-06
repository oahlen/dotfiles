return {
    "copilot",
    keys = {
        { "<leader>am", "<CMD>CopilotChatToggle<CR>", desc = "Copilot Chat Toggle" },
        { "<leader>ax", "<CMD>CopilotChatReset<CR>", desc = "Copilot Chat Reset" },
    },
    after = function()
        require("copilot").setup({
            suggestion = { enabled = false },
            panel = { enabled = false },
        })

        require("CopilotChat").setup({
            model = "gpt-5.1",
        })

        vim.keymap.set(
            "v",
            "<leader>e",
            "<CMD>CopilotChatExplain<CR>",
            { noremap = true, silent = true, desc = "Copilot Chat Explain" }
        )
    end,
}
