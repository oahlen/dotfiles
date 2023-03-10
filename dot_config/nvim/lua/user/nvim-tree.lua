local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
    return
end

nvim_tree.setup {
    sync_root_with_cwd = true,
    renderer = {
        icons = {
            symlink_arrow = " -> ",
            show = {
                file = false,
                folder = false,
            },
            glyphs = {
                default = "",
                symlink = "";
                bookmark = "",
                folder = {
                    arrow_closed = ">",
                    arrow_open = "v"
                },
                git = {
                    unstaged = "x",
                    staged = "S",
                    unmerged = "m",
                    renamed = "R",
                    deleted = "D",
                    untracked = "U",
                    ignored = "I"
                }
            }
        },
        special_files = { "Cargo.toml", "Dockerfile", "Makefile", "README.md", "readme.md" },
    },
    filters = {
        custom = {
            "^.git$"
        }
    },
    view = {
        width = 40,
        signcolumn = "no"
    }
}

vim.keymap.set("n", "<leader>e", "<CMD>NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>E", "<CMD>NvimTreeFindFile<CR>")
