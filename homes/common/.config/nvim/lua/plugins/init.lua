return {
    {
        "nvim-autopairs",
        event = "BufEnter",
        after = function()
            require("nvim-autopairs").setup()
        end,
    },
    {
        "Comment",
        event = "BufEnter",
        after = function()
            require("Comment").setup()
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
        "nvim-surround",
        event = "BufEnter",
        after = function()
            require("nvim-surround").setup()
        end,
    },
    {
        "colorizer",
        event = "BufEnter",
        after = function()
            require("colorizer").setup()
        end,
    },
}
