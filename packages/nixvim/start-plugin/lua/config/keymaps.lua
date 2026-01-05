-- Keymaps
-- Yank to end of line
vim.keymap.set("n", "Y", "y$")

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
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Keep cursor in the middle of screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep cursor in the middle of screen for search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Faster way to enter insert mode
vim.keymap.set("v", "i", "<ESC>i")
vim.keymap.set("v", "a", "<ESC>a")

-- Sane way of exiting terminal mode
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>")

-- Close current buffer
vim.keymap.set("n", "<leader>q", "<CMD>bp<BAR>bd#<CR>", { desc = "Close Current Buffer" })

-- Tab operations
vim.keymap.set("n", "<leader>ta", "<CMD>$tabnew<CR>", { desc = "New Tab" })
vim.keymap.set("n", "<leader>tc", "<CMD>tabclose<CR>", { desc = "Close Current Tab" })

-- Clear highlights
vim.keymap.set("n", "<leader>ch", "<CMD>nohl<CR>", { desc = "Clear Search Highlights" })

-- Toggle background color
vim.keymap.set("n", "<leader>ct", function()
    if vim.o.background == "dark" then
        vim.o.background = "light"
    else
        vim.o.background = "dark"
    end
end, { desc = "Toggle background color" })

-- Spell
vim.keymap.set("n", "<leader>se", "<CMD>set spell spelllang=en<CR>", { desc = "Set English spelling" })

-- Insert functions
vim.keymap.set("n", "<leader>ii", "<CMD>r!uuidgen<CR>", { desc = "Insert UUID" })
