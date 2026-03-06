require("luasnip/loaders/from_vscode").lazy_load()

local kind_icons = {
    Text = "",
    Method = "󰆧",
    Function = "󰊕",
    Constructor = "",
    Field = "󰇽",
    Variable = "󰂡",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "󰅲",
}

require("blink.cmp").setup({
    completion = {
        accept = {
            auto_brackets = { enabled = true },
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 250,
        },
        ghost_text = {
            enabled = false,
        },
        menu = {
            max_height = 20,
            draw = {
                components = {
                    kind_icon = {
                        text = function(ctx)
                            return kind_icons[ctx.kind]
                        end,
                    },
                    kind = {
                        text = function(ctx)
                            if ctx.source_name == "Spell" then
                                return "Spell"
                            end
                            return ctx.kind
                        end,
                    },
                },
                columns = {
                    { "label", "label_description", gap = 1 },
                    { "kind_icon", "kind", gap = 1 },
                },
            },
        },
    },
    fuzzy = {
        implementation = "rust",
    },
    keymap = {
        preset = "default",
        ["<Enter>"] = {
            function(cmp)
                if cmp.snippet_active() then
                    return cmp.accept()
                else
                    return cmp.select_and_accept()
                end
            end,
            "select_and_accept",
            "fallback",
        },
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    },
    sources = {
        default = { "lsp", "path", "spell", "snippets", "buffer" },

        providers = {
            spell = {
                name = "Spell",
                module = "blink-cmp-spell",
                opts = {
                    -- Only enable source in `@spell` captures, and disable it in `@nospell` captures.
                    enable_in_context = function()
                        local curpos = vim.api.nvim_win_get_cursor(0)
                        local captures = vim.treesitter.get_captures_at_pos(0, curpos[1] - 1, curpos[2] - 1)
                        local in_spell_capture = false
                        for _, cap in ipairs(captures) do
                            if cap.capture == "spell" then
                                in_spell_capture = true
                            elseif cap.capture == "nospell" then
                                return false
                            end
                        end
                        return in_spell_capture
                    end,
                },
            },
        },
    },
})
