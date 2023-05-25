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
vim.keymap.set("n", "<leader>l", vim.diagnostic.setloclist)

local on_attach = function(client, bufnr)
    client.server_capabilities.semanticTokensProvider = nil
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    local telescope = require('telescope.builtin')
    local opts = { noremap = true, silent = true, buffer = bufnr }

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", telescope.lsp_implementations, opts)
    vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", telescope.lsp_references, opts)
    vim.keymap.set("n", "==", function() vim.lsp.buf.format { async = true } end, opts)
end

lsp_config.omnisharp.setup {
    handlers = {
        ["textDocument/definition"] = require('omnisharp_extended').handler,
    },
    cmd = {
        "omnisharp",
        "--languageserver",
        "--hostPID",
        tostring(vim.fn.getpid())
    },
    on_attach = on_attach
}

lsp_config.rust_analyzer.setup {
    on_attach = on_attach
}

lsp_config.pyright.setup {
    on_attach = on_attach
}

lsp_config.tsserver.setup {
    on_attach = on_attach
}

lsp_config.svelte.setup {
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
