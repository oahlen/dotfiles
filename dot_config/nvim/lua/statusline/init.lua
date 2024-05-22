local M = {}

M.symbols = {
    error = "󰅚 ",
    warn = "󰀪 ",
    info = "󰋽 ",
    hint = "󰌶 "
}

function M.lsp_diagnostics()
    if vim.api.nvim_get_mode()["mode"] ~= "n" then
        return ""
    end

    local parts = {}

    local num_errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    if num_errors > 0 then
        table.insert(parts, M.symbols.error .. num_errors)
    end

    local num_warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    if num_warnings > 0 then
        table.insert(parts, M.symbols.warn .. num_warnings)
    end

    return table.concat(parts, " ")
end

function M.lsp_client()
    local clients = vim.lsp.get_active_clients({ bufnr = vim.api.nvim_get_current_buf() })

    if #(clients) > 0 then
        return " " .. clients[1].name
    end

    return ""
end

function M.branch()
    if vim.b.gitsigns_head ~= nil then
        return " " .. vim.b.gitsigns_head
    end

    return ""
end

function M.active()
    if vim.bo.filetype == "NvimTree" then
        return " %{fnamemodify(getcwd(), ':~')}"
    end

    local parts = {
        " %t [%n] %m",
        [[%{luaeval("require'statusline'.branch()")}]],
        [[%{luaeval("require'statusline'.lsp_client()")}]],
        [[%{luaeval("require'statusline'.lsp_diagnostics()")}]],
        "%=",
        "%{&fenc?&fenc:&enc}",
        "%{&ff}",
        "%{&ft!=#''?&ft:'none'}",
        "[%3l:%-2v]",
        "[%3P] "
    }

    return table.concat(parts, "    ")
end

function M.inactive()
    return vim.bo.filetype == "NvimTree"
        and " %{fnamemodify(getcwd(), ':~')}"
        or " %t [%n] %m%=[%3l:%-2v]    [%3P] "
end

local group = vim.api.nvim_create_augroup("statusline", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    pattern = "*",
    callback = function()
        vim.wo.statusline = M.active()
    end,
    group = group
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
    pattern = "*",
    callback = function()
        vim.wo.statusline = M.inactive()
    end,
    group = group
})

return M
