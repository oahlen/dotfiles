-- Yank to end of line
vim.keymap.set("n", "Y", "y$", { desc = "Yank to End of Line" })

-- System clipboard
vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y', { noremap = true, silent = true, desc = "Yank to Clipboard" })
vim.keymap.set(
    { "n", "v", "x" },
    "<leader>Y",
    '"+yy',
    { noremap = true, silent = true, desc = "Yank Line to Clipboard" }
)
vim.keymap.set({ "n", "v", "x" }, "<leader>p", '"+p', { noremap = true, silent = true, desc = "Paste from Clipboard" })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move Focus to the Left Window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move Focus to the Right Window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move Focus to the Lower Window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move Focus to the Upper Window" })

-- Window resize
vim.keymap.set("n", "<C-Up>", "<CMD>resize +5<CR>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-Down>", "<CMD>resize -5<CR>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-Left>", "<CMD>vertical resize -5<CR>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<C-Right>", "<CMD>vertical resize +5<CR>", { desc = "Increase Window Width" })

-- Keep cursor in the middle of screen
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Jump Half-Page Down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Jump Half-Page Up" })

-- Keep cursor in the middle of screen for search results
vim.keymap.set("n", "n", "nzzzv", { desc = "Next Result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous Result" })

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", { desc = "Decrease Indent" })
vim.keymap.set("v", ">", ">gv", { desc = "Increase Indent" })

-- Faster way to enter insert mode
vim.keymap.set("v", "i", "<ESC>i", { desc = "Insert Text (Visual)" })
vim.keymap.set("v", "a", "<ESC>a", { desc = "Append Text (Visual)" })

-- Sane way of exiting terminal mode
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", { desc = "Exit Terminal Mode" })

-- Close current buffer
vim.keymap.set("n", "<leader>q", "<CMD>bp<BAR>bd#<CR>", { desc = "Close Current Buffer" })

-- Tab operations
vim.keymap.set("n", "<leader>ta", "<CMD>$tabnew<CR>", { desc = "New Tab" })
vim.keymap.set("n", "<leader>tc", "<CMD>tabclose<CR>", { desc = "Close Current Tab" })

-- Clear highlights
vim.keymap.set("n", "<Esc>", "<CMD>nohl<CR>", { desc = "Clear Search Highlights" })

-- Toggle actions
vim.keymap.set("n", "<leader>ns", "<CMD>set spell! spelllang=en<CR>", { desc = "Toggle Spelling" })
vim.keymap.set("n", "<leader>nb", "<CMD>ToggleBackground<CR>", { desc = "Toggle Background" })
