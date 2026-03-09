return {
    {
        "Comment",
        event = "BufEnter",
        after = function()
            require("Comment").setup()
        end,
    },
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
    {
        "nvim-surround",
        event = "BufEnter",
        after = function()
            require("nvim-surround").setup()
        end,
    },
}
