vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>")

-- Yank to end of line
vim.keymap.set("n", "Y", "y$")

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Keep cursor in the middle of screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Clear highlights
vim.keymap.set("n", "<leader>ch", "<CMD>nohl<CR>")

-- Tab operations
vim.keymap.set("n", "<leader>ta", "<CMD>$tabnew<CR>")
vim.keymap.set("n", "<leader>tc", "<CMD>tabclose<CR>")

-- Close current buffer
vim.keymap.set("n", "<leader>q", "<CMD>bp<BAR>bd#<CR>")

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Faster way to enter insert mode
vim.keymap.set("v", "i", "<ESC>i")
vim.keymap.set("v", "a", "<ESC>a")

-- Sane way of exiting terminal mode
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>")

-- Format json
vim.keymap.set("n", "<leader>jf", "<CMD>%! jq<CR>")
