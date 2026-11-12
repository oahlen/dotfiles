if vim.g.nix then
    return
end

vim.pack.add({
    "https://github.com/carlos-algms/agentic.nvim",
    "https://github.com/oahlen/aurora.nvim",
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
    "https://github.com/ibhagwan/fzf-lua",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/rebelot/heirline.nvim",
    "https://github.com/lukas-reineke/indent-blankline.nvim",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/catgoose/nvim-colorizer.lua",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/nvim-tree/nvim-tree.lua",
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/MeanderingProgrammer/render-markdown.nvim",
    "https://github.com/pablos123/shellcheck.nvim",
    "https://github.com/folke/which-key.nvim",
}, { confirm = false })

require("mason").setup()

local parsers = vim.fs.joinpath(vim.fn.stdpath("config"), "parsers.json")

if vim.fn.executable("tree-sitter") == 1 then
    require("nvim-treesitter").install(vim.json.decode(table.concat(vim.fn.readfile(parsers), "\n")))
else
    vim.notify("tree-sitter CLI not found, skipping parser install", vim.log.levels.WARN)
end
