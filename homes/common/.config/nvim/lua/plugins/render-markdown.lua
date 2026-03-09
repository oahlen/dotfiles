return {
    "render-markdown",
    ft = { "copilot-chat", "markdown" },
    after = function()
        require("render-markdown").setup({
            code = { sign = false },
            completions = { lsp = { enabled = true } },
            heading = { enabled = false },
            file_types = {
                "markdown",
                "copilot-chat",
            },
            latex = { enabled = false },
            html = {
                comment = {
                    conceal = false,
                },
            },
        })
    end,
}
