-- Yank to end of line
vim.keymap.set("n", "Y", "y$", { desc = "Yank to end of line" })

-- System clipboard
vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y', { noremap = true, silent = true, desc = "Yank to clipboard" })
vim.keymap.set(
    { "n", "v", "x" },
    "<leader>Y",
    '"+yy',
    { noremap = true, silent = true, desc = "Yank line to clipboard" }
)
vim.keymap.set({ "n", "v", "x" }, "<leader>p", '"+p', { noremap = true, silent = true, desc = "Paste from clipboard" })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move focus to the upper window" })

-- Keep cursor in the middle of screen
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Jump half-page down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Jump half-page up" })

-- Keep cursor in the middle of screen for search results
vim.keymap.set("n", "n", "nzzzv", { desc = "Next result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous result" })

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", { desc = "Decrease indent" })
vim.keymap.set("v", ">", ">gv", { desc = "Increase indent" })

-- Faster way to enter insert mode
vim.keymap.set("v", "i", "<ESC>i", { desc = "Insert text (Visual)" })
vim.keymap.set("v", "a", "<ESC>a", { desc = "Append text (Visual)" })

-- Sane way of exiting terminal mode
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Close current buffer
vim.keymap.set("n", "<leader>q", "<CMD>bp<BAR>bd#<CR>", { desc = "Close current buffer" })

-- Tab operations
vim.keymap.set("n", "<leader>ta", "<CMD>$tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<leader>tc", "<CMD>tabclose<CR>", { desc = "Close current tab" })

-- Clear highlights
vim.keymap.set("n", "<Esc>", "<CMD>nohl<CR>", { desc = "Clear search highlights" })

-- Spell
vim.keymap.set("n", "<leader>ss", "<CMD>set spell! spelllang=en<CR>", { desc = "Toggle spelling" })

-- Insert functions
vim.keymap.set("n", "<leader>ii", "<CMD>r!uuidgen<CR>", { desc = "Insert UUID" })
