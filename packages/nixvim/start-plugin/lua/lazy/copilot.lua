return {
    "copilot",
    keys = {
        { "<leader>m", "<CMD>CopilotChatToggle<CR>" },
        { "<leader>x", "<CMD>CopilotChatReset<CR>" },
    },
    after = function()
        require("copilot").setup({
            suggestion = { enabled = false },
            panel = { enabled = false },
        })

        require("CopilotChat").setup({
            model = "gpt-5.1",
        })

        vim.keymap.set("v", "<leader>e", "<CMD>CopilotChatExplain<CR>")
    end,
}
