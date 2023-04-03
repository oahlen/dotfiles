vim.o.autoindent = true
vim.o.backup = false
vim.o.clipboard = "unnamedplus"
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.guifont = "JetBrains Mono:h11"
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.laststatus = 2
vim.o.mouse = "a"
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 10
vim.o.shiftwidth = 4
vim.o.showmatch = true
vim.o.showmode = true
vim.o.shortmess = "atI"
vim.o.smartcase = true
vim.o.softtabstop = 4
vim.o.swapfile = false
vim.o.tabstop = 4
vim.o.termguicolors = true

vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴"

-- Disable some builtin vim plugins
vim.g.loaded_2html_plugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_logipat = 1
vim.g.loaded_man = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1

-- Set colorscheme
vim.cmd.colorscheme("iceberg")

-- Fix cursor in terminal on exiting
vim.cmd [[
  augroup RestoreCursorShapeOnExit
    autocmd!
    autocmd VimLeave * set guicursor=a:ver24
  augroup END
]]
