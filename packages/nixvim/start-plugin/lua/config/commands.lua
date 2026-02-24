vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    desc = "Force update csharp buffers when using csharp_ls",
    group = vim.api.nvim_create_augroup("csharp-buffer-update", { clear = true }),
    pattern = "*.cs",
    callback = function(args)
        local bufnr = args.buf
        local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "csharp_ls" })
        if #clients == 0 then
            return
        end

        -- Notify the LSP server that the document changed (even if it didn't)
        -- This triggers diagnostic re-evaluation
        local params = vim.lsp.util.make_text_document_params(bufnr)
        local text = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n") .. "\n"

        for _, client in ipairs(clients) do
            ---@diagnostic disable-next-line: param-type-mismatch
            client.notify("textDocument/didChange", {
                textDocument = {
                    uri = params.uri,
                    version = vim.lsp.util.buf_versions[bufnr] or 0,
                },
                contentChanges = {
                    { text = text },
                },
            })
        end
    end,
})

-- vim.api.nvim_create_autocmd("BufWritePost", {
--     pattern = "*.cs",
--     callback = function()
--         for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
--             if vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].filetype == "cs" then
--                 local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "csharp_ls" })
--                 for _, client in ipairs(clients) do
--                     local params = vim.lsp.util.make_text_document_params(bufnr)
--                     ---@diagnostic disable-next-line: param-type-mismatch
--                     client.notify("textDocument/didChange", {
--                         textDocument = {
--                             uri = params.uri,
--                             version = vim.lsp.util.buf_versions[bufnr] or 0,
--                         },
--                         contentChanges = {
--                             {
--                                 text = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n") .. "\n",
--                             },
--                         },
--                     })
--                 end
--             end
--         end
--     end,
-- })
