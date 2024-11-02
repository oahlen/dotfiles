return {
    {
        "folke/which-key.nvim",
        config = function()
            local wk = require("which-key")

            wk.add({
                { "<leader>c", group = "[C]ode" },
                { "<leader>d", group = "[D]ebug" },
                { "<leader>h", group = "[H]istory" },
                { "<leader>t", group = "[T]ab" }
            })
        end
    }
}
