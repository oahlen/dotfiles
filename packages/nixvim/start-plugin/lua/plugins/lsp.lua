local on_init = function(client, _)
    -- Disable semantic tokens
    client.server_capabilities.semanticTokensProvider = nil
end

local on_attach = function(_, bufnr)
    local map = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
    end

    local finder = require("fzf-lua")
    map("gi", finder.lsp_implementations, "Goto Implementation")
    map("gr", finder.lsp_references, "Goto References")

    map("gd", finder.lsp_definitions, "Goto Definition")
    map("gD", finder.lsp_declarations, "Goto Declaration")

    map("gn", function()
        vim.diagnostic.jump({ count = 1, float = true })
    end, "Goto Next")
    map("gN", function()
        vim.diagnostic.jump({ count = -1, float = true })
    end, "Goto Prev")

    map("K", vim.lsp.buf.hover, "Hover Documentation")
    map("<C-s>", vim.lsp.buf.signature_help, "Signature Help")
    map("<leader>D", vim.lsp.buf.type_definition, "Type Definition")
    map("<leader>rn", vim.lsp.buf.rename, "LSP Rename")
    map("<leader>ca", finder.lsp_code_actions, "Code Action")
    map("==", function()
        vim.lsp.buf.format({ async = true })
    end, "Format Code")
end

local enable = function(name, opts)
    local config = vim.tbl_deep_extend("force", { on_init = on_init, on_attach = on_attach }, opts or {})
    vim.lsp.config(name, config)
    vim.lsp.enable(name)
end

enable("lua_ls", {
    settings = {
        Lua = {
            completion = {
                keywordSnippet = "Disable",
            },
            diagnostics = {
                globals = { "use", "vim" },
                disable = { "lowercase-global" },
            },
            runtime = {
                version = "LuaJIT",
                path = vim.split(package.path, ";"),
            },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                },
            },
        },
    },
})

enable("csharp_ls")
-- require("csharpls_extended").buf_read_cmd_bind()
enable("cssls")
enable("html")
enable("nil_ls")
enable("pyright")
enable("rust_analyzer")
enable("svelte")
enable("ts_ls")
