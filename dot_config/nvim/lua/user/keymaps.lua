vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Remap space as leader key
map("", "<Space>", "<Nop>")

-- Yank to end of line
map("n", "Y", "y$")

-- Better window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Keep cursor in the middle of screen
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Clear highlights
map("n", "<leader>ch", "<CMD>nohl<CR>")

-- Tab operations
map("n", "<leader>ta", "<CMD>$tabnew<CR>")
map("n", "<leader>tc", "<CMD>tabclose<CR>")

-- Close current buffer
map("n", "<leader>q", "<CMD>bp<BAR>bd#<CR>")

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Faster way to enter insert mode
map("v", "i", "<ESC>i")
map("v", "a", "<ESC>a")

-- Sane way of exiting terminal mode
map("t", "<ESC>", "<C-\\><C-n>")

-- Format json
map("n", "<leader>jf", "<CMD>%! jq<CR>")
