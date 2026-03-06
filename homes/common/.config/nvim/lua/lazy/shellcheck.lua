return {
    {
        "shellcheck",
        ft = "sh",
        after = function()
            require("shellcheck-nvim").setup()
        end,
    },
}
