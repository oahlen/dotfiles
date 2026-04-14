return {
    "which-key",
    event = "UIEnter",
    after = function()
        local wk = require("which-key")

        wk.setup({
            icons = {
                mappings = false,
            },
        })

        wk.add({
            { "<leader>a", group = "Agentic Actions" },
            { "<leader>c", group = "Code Actions" },
            { "<leader>h", group = "Git Actions" },
            { "<leader>n", group = "Toggle Actions" },
            { "<leader>t", group = "Tab Actions" },
            { "gr", group = "LSP Actions" },
        })
    end,
}
