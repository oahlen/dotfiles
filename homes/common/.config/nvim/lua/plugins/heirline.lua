local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local function setup_colors()
    return {
        red = utils.get_highlight("DiagnosticError").fg,
        green = utils.get_highlight("String").fg,
        orange = utils.get_highlight("Constant").fg,
        blue = utils.get_highlight("Function").fg,
        purple = utils.get_highlight("Statement").fg,
        cyan = utils.get_highlight("PreProc").fg,
        fg = utils.get_highlight("StatusLine").fg,
        bg = utils.get_highlight("StatusLine").bg,

        diag_error = utils.get_highlight("DiagnosticError").fg,
        diag_warn = utils.get_highlight("DiagnosticWarn").fg,
        diag_info = utils.get_highlight("DiagnosticInfo").fg,
        diag_hint = utils.get_highlight("DiagnosticHint").fg,
    }
end

local Align = { provider = "%=" }
local Space = { provider = "    " }
local Padding = { provider = " " }

local FileTree = {
    condition = function()
        return vim.bo.filetype == "NvimTree"
    end,
    provider = function()
        local icon = " "
        local cwd = vim.fn.getcwd(0)
        cwd = vim.fn.fnamemodify(cwd, ":~")

        if not conditions.width_percent_below(#cwd, 0.25) then
            cwd = vim.fn.pathshorten(cwd)
        end

        local trail = cwd:sub(-1) == "/" and "" or "/"
        return icon .. " " .. cwd .. trail
    end,
    hl = { fg = "blue" },
}

local FileNameBlock = {
    condition = function()
        return vim.bo.filetype ~= "NvimTree"
    end,
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
    end,
}

local FileIcon = {
    init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ":e")
        self.icon, self.icon_color =
            require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
    end,
    provider = function(self)
        return self.icon and (self.icon .. " ")
    end,
    hl = function(self)
        return { fg = self.icon_color }
    end,
}

local FileName = {
    provider = function(self)
        local filename = vim.fn.fnamemodify(self.filename, ":.")

        if filename == "" then
            return "[No Name]"
        end

        if not conditions.width_percent_below(#filename, 0.25) then
            filename = vim.fn.pathshorten(filename)
        end

        return filename
    end,
    hl = { fg = "blue" },
}

local FileFlags = {
    {
        condition = function()
            return vim.bo.modified
        end,
        provider = " [+]",
        hl = { fg = "green" },
    },
    {
        condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = " ",
        hl = { fg = "orange" },
    },
}

local FileNameModifier = {
    hl = function()
        if vim.bo.modified then
            -- use `force` because we need to override the child's hl foreground
            return { fg = "cyan", bold = true, force = true }
        end
    end,
}

FileNameBlock =
    utils.insert(FileNameBlock, FileIcon, utils.insert(FileNameModifier, FileName), FileFlags, { provider = "%<" })

local FileEncoding = {
    provider = function()
        local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc
        return enc ~= "utf-8" and enc:upper()
    end,
    hl = { fg = "cyan" },
}

local FileFormat = {
    provider = function()
        local fmt = vim.bo.fileformat
        return fmt ~= "unix" and fmt:upper()
    end,
    hl = { fg = "cyan" },
}

local LSPActive = {
    condition = conditions.lsp_attached,
    update = { "LspAttach", "LspDetach" },
    provider = function()
        local names = {}

        for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
            table.insert(names, server.name)
        end

        return " [" .. table.concat(names, " ") .. "]"
    end,
    hl = { fg = "green" },
}

local Diagnostics = {
    condition = conditions.has_diagnostics,
    static = {
        signs = vim.diagnostic.config().signs.text,
    },
    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,
    update = { "DiagnosticChanged", "BufEnter" },
    {
        provider = function(self)
            return self.errors > 0 and (self.signs[vim.diagnostic.severity.ERROR] .. self.errors .. " ")
        end,
        hl = { fg = "diag_error" },
    },
    {
        provider = function(self)
            return self.warnings > 0 and (self.signs[vim.diagnostic.severity.WARN] .. self.warnings .. " ")
        end,
        hl = { fg = "diag_warn" },
    },
    {
        provider = function(self)
            return self.info > 0 and (self.signs[vim.diagnostic.severity.INFO] .. self.info .. " ")
        end,
        hl = { fg = "diag_info" },
    },
    {
        provider = function(self)
            return self.hints > 0 and (self.signs[vim.diagnostic.severity.HINT] .. self.hints)
        end,
        hl = { fg = "diag_hint" },
    },
}

local Git = {
    condition = conditions.is_git_repo,
    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
    end,
    provider = function(self)
        return " " .. self.status_dict.head
    end,
    hl = { fg = "purple" },
}

local Ruler = {
    provider = "%7(%l/%3L%) %P",
}

local Statusline = {
    condition = conditions.is_active,
    hl = { fg = "fg", bg = "bg" },
    Padding,
    FileTree,
    FileNameBlock,
    Space,
    FileEncoding,
    Space,
    FileFormat,
    Align,
    Diagnostics,
    Space,
    LSPActive,
    Space,
    Git,
    Space,
    Ruler,
    Padding,
}

local InactiveStatusline = {
    condition = conditions.is_not_active,
    Padding,
    FileNameBlock,
    Align,
    Ruler,
    Padding,
}

local Tabpage = {
    provider = function(self)
        return "%" .. self.tabnr .. "T " .. self.tabpage .. " %T"
    end,
    hl = function(self)
        if not self.is_active then
            return { fg = "fg" }
        else
            return { fg = "bg", bg = "orange", bold = true }
        end
    end,
}

local TabpageClose = {
    provider = "%999X X %X",
    hl = { fg = "bg", bg = "red", bold = true },
}

local TabPages = {
    condition = function()
        return #vim.api.nvim_list_tabpages() >= 2
    end,
    utils.make_tablist(Tabpage),
    Align,
    TabpageClose,
}

local heirline = require("heirline")
heirline.load_colors(setup_colors)
heirline.setup({
    statusline = {
        Statusline,
        InactiveStatusline,
    },
    tabline = { TabPages },
})

vim.api.nvim_create_augroup("Heirline", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        utils.on_colorscheme(setup_colors)
    end,
    group = "Heirline",
})
