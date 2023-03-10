local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

telescope.setup {
    defaults = {
        file_ignore_patterns = {
            "%.git/",
            "node_modules/"
        }
    },
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {}
        }
    },
    pickers = {
        find_files = {
            hidden = true
        },
        live_grep = {
            additional_args = function(_) return { "--hidden" } end
        },
        lsp_references = {
            show_line = false
        }
    }
}

telescope.load_extension("ui-select")
telescope.load_extension("fzf")

local builtin = require("telescope.builtin")
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>f", builtin.find_files, opts)
vim.keymap.set("n", "<leader>g", builtin.live_grep, opts)
vim.keymap.set("n", "<leader>b", builtin.buffers, opts)
vim.keymap.set("n", "<leader>s", builtin.treesitter, opts)
vim.keymap.set("n", "<leader>d", builtin.diagnostics, opts)
