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
