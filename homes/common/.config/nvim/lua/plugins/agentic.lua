return {
    "agentic",
    keys = {
        {
            "<leader>aa",
            function()
                require("agentic").toggle()
            end,
            desc = "Toggle Agentic Chat",
        },
        {
            "<leader>an",
            function()
                require("agentic").new_session()
            end,
            desc = "New Agentic Session",
        },
        {
            "<leader>ar",
            function()
                require("agentic").restore_session()
            end,
            desc = "Restore Agentic Session",
        },
        {
            "<leader>af",
            function()
                require("agentic").add_file()
            end,
            desc = "Add File to Context",
        },
        {
            "<leader>as",
            function()
                require("agentic").add_selection()
            end,
            mode = "v",
            desc = "Add Selection to Context",
        },
        {
            "<leader>ax",
            function()
                require("agentic").stop_generation()
            end,
            desc = "Stop Agentic Generation",
        },
    },
    after = function()
        require("agentic").setup({
            provider = "opencode-acp",
            diagnostic_icons = {
                error = "󰅚 ",
                warn = "󰀪 ",
                info = "󰋽 ",
                hint = "󰌶 ",
            },
        })
    end,
}
