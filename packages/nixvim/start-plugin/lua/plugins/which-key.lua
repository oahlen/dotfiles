local wk = require("which-key")

wk.setup({
    icons = {
        mappings = false,
    },
})

wk.add({
    { "<leader>a", group = "Copilot Actions" },
    { "<leader>c", group = "Code Actions" },
    { "<leader>h", group = "Git Actions" },
    { "<leader>n", group = "Toggle Actions" },
    { "<leader>t", group = "Tab Actions" },
})
