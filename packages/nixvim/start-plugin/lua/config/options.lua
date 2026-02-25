-- Options

if vim.fn.executable("dconf") == 1 then
    -- Get the background and colorscheme settings from environment
    local theme = vim.system({ "dconf", "read", "/org/gnome/desktop/interface/color-scheme" }):wait()
    vim.o.background = theme.stdout:find("prefer-light", 1, true) and "light" or "dark"
else
    vim.o.background = "dark"
end

vim.cmd.colorscheme(os.getenv("NVIM_COLORSCHEME") or "tokyonight")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.autoindent = true
vim.o.backup = false
vim.o.breakindent = true
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.laststatus = 3
vim.o.mouse = "a"
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 10
vim.o.shiftwidth = 4
vim.o.shortmess = "IF"
vim.o.showmatch = true
vim.o.showmode = true
vim.o.smartcase = true
vim.o.softtabstop = 4
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.tabstop = 4
vim.o.termguicolors = true
vim.o.undofile = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Diagnostic settings
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
    },
    virtual_lines = false,
    virtual_text = {
        current_line = false,
        prefix = "●" .. " ",
    },
})

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

-- Disable providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
