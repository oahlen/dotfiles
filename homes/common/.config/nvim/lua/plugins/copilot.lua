return {
    "copilot",
    keys = {
        { "<leader>am", "<CMD>CopilotChatToggle<CR>", desc = "Copilot Chat Toggle" },
        { "<leader>ar", "<CMD>CopilotChatReset<CR>", desc = "Copilot Chat Reset" },
        { "<leader>e", "<CMD>CopilotChatExplain<CR>", mode = "v", desc = "Copilot Chat Explain" },
    },
    after = function()
        require("copilot").setup({
            suggestion = { enabled = false },
            panel = { enabled = false },
        })

        require("CopilotChat").setup({
            model = "gpt-5.1",
        })
    end,
}
