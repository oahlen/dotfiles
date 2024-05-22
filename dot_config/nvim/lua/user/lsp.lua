local lsp_config = require("lspconfig")

local signs = {
    Error = "󰅚 ",
    Warn = "󰀪 ",
    Info = "󰋽 ",
    Hint = "󰌶 "
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
    virtual_text = {
        prefix = " ●"
    }
})

vim.keymap.set("n", "gn", vim.diagnostic.goto_next)
vim.keymap.set("n", "gN", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<leader>l", vim.diagnostic.setloclist, { desc = "Set LOC list" })

local on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    local telescope = require('telescope.builtin')

    local map = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
    end

    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    map("K", vim.lsp.buf.hover, "Hover Documentation")
    map("gi", telescope.lsp_implementations, "[G]oto [I]mplementation")
    map("<C-s>", vim.lsp.buf.signature_help, "Signature help")
    -- map("<leader>wa", vim.lsp.buf.add_workspace_folder, "")
    -- map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "")
    -- map("<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "")
    map("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    map("gr", telescope.lsp_references, "[G]oto [R]eferences")
    map("==", function() vim.lsp.buf.format { async = true } end, "Format code")
end

lsp_config.nil_ls.setup {
    on_attach = on_attach
}

lsp_config.lua_ls.setup {
    on_attach = on_attach,
    settings = {
        Lua = {
            completion = {
                keywordSnippet = "Disable",
            },
            diagnostics = {
                globals = { "use", "vim" },
                disable = { "lowercase-global" }
            },
            runtime = {
                version = "LuaJIT",
                path = vim.split(package.path, ";")
            },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
                }
            }
        }
    }
}

lsp_config.rust_analyzer.setup { on_attach = on_attach }
lsp_config.pyright.setup { on_attach = on_attach }
lsp_config.tsserver.setup { on_attach = on_attach }
lsp_config.html.setup { on_attach = on_attach }
lsp_config.cssls.setup { on_attach = on_attach }

lsp_config.svelte.setup { on_attach = on_attach }

lsp_config.omnisharp.setup {
    handlers = {
        ["textDocument/definition"] = require('omnisharp_extended').handler,
    },
    cmd = {
        "OmniSharp",
        "--languageserver",
        "--hostPID",
        tostring(vim.fn.getpid())
    },
    on_attach = on_attach
}
