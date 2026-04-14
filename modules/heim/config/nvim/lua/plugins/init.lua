return {
    {
        "colorizer",
        event = "BufEnter",
        after = function()
            require("colorizer").setup()
        end,
    },
    {
        "ibl",
        event = "BufEnter",
        after = function()
            require("ibl").setup()
        end,
    },
    {
        "nvim-autopairs",
        event = "BufEnter",
        after = function()
            require("nvim-autopairs").setup()
        end,
    },
}
