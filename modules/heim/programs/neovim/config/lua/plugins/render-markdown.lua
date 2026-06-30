return {
    "render-markdown",
    ft = { "AgenticChat", "markdown", "md" },
    after = function()
        require("render-markdown").setup({
            code = { sign = false },
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
            sign = {
                enabled = false,
            },
        })
    end,
}
