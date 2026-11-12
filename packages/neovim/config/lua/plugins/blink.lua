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
        ["<Enter>"] = { "select_and_accept", "fallback" },
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    },
    sources = {
        default = { "lsp", "path", "buffer" },
    },
})
