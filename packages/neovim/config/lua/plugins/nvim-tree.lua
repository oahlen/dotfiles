require("nvim-tree").setup({
    sync_root_with_cwd = true,
    renderer = {
        special_files = {
            "Cargo.toml",
            "Containerfile",
            "Dockerfile",
            "flake.nix",
            "flake.lock",
            "Makefile",
            "README.md",
            "readme.md",
        },
    },
    filters = {
        custom = {
            "^.git$",
        },
    },
    view = {
        width = 40,
        signcolumn = "no",
    },
})

vim.keymap.set("n", "<leader>e", "<CMD>NvimTreeToggle<CR>", { desc = "Toggle File Tree" })
vim.keymap.set("n", "<leader>E", "<CMD>NvimTreeFindFile<CR>", { desc = "Find in File Tree" })
