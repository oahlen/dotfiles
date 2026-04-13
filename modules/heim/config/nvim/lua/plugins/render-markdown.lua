return {
    "render-markdown",
    ft = { "AgenticChat", "markdown", "md" },
    after = function()
        require("render-markdown").setup({
            code = { sign = false },
            completions = { lsp = { enabled = true } },
            heading = { enabled = false },
            file_types = {
                "AgenticChat",
                "markdown",
                "md",
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
