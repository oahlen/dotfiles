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

vim.g.have_nerd_font = true

vim.o.autoindent = true
vim.o.backup = false
vim.o.breakindent = true
vim.o.confirm = true
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.inccommand = "split"
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
vim.o.timeoutlen = 300
vim.o.undofile = true
vim.o.updatetime = 250

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
