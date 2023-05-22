local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazy_path,
    })
end

vim.opt.rtp:prepend(lazy_path)

require("lazy").setup({
    { "nvim-lua/plenary.nvim", lazy = true },
    { "nvim-lua/popup.nvim",   lazy = true },
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        config = function()
            require("nvim-web-devicons").setup {
                override_by_extension = {
                    ["csproj"] = {
                        name = "CSProj",
                        icon = "",
                        color = "#017bcd"
                    },
                    ["rs"] = {
                        name = "Rust",
                        icon = "",
                        color = "#f74c00"
                    }
                }
            }
        end
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-telescope/telescope-ui-select.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make"
            }
        }
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = { "Hoffs/omnisharp-extended-lsp.nvim" }
    },

    {
        "williamboman/mason.nvim",
        config = function() require("mason").setup() end
    },

    {
        "mfussenegger/nvim-dap",
        dependencies = { "theHamsta/nvim-dap-virtual-text" }
    },

    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",

            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
            "saadparwaiz1/cmp_luasnip",
        }
    },

    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = {
                    "bash",
                    "c",
                    "cmake",
                    "comment",
                    "c_sharp",
                    "css",
                    "dockerfile",
                    "fish",
                    "gitignore",
                    "go",
                    "html",
                    "javascript",
                    "json",
                    "lua",
                    "make",
                    "markdown",
                    "python",
                    "rust",
                    "scss",
                    "sql",
                    "svelte",
                    "toml",
                    "typescript",
                    "vim",
                    "yaml"
                },
                sync_install = false,
                ignore_install = {},
                highlight = {
                    enable = true,
                    disable = {},
                    additional_vim_regex_highlighting = false
                },
                indent = {
                    enable = true
                }
            }
        end,
        cmd = "TSUpdate"
    },

    {
        "nvim-tree/nvim-tree.lua",
        keys = {
            { "<leader>e", "<CMD>NvimTreeToggle<CR>",   desc = "NvimTree Toggle" },
            { "<leader>E", "<CMD>NvimTreeFindFile<CR>", desc = "NvimTree Find File" },
        },
        config = function()
            require("nvim-tree").setup {
                hijack_cursor = true,
                sync_root_with_cwd = true,
                renderer = {
                    special_files = { "Cargo.toml", "Dockerfile", "Makefile", "README.md", "readme.md" },
                },
                filters = {
                    custom = {
                        "^.git$"
                    }
                },
                view = {
                    width = 40,
                    signcolumn = "no"
                }
            }
        end
    },

    {
        "ggandor/leap.nvim",
        config = function()
            require("leap").add_default_mappings()
        end
    },

    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup {
                check_ts = true,
                ts_config = {},
                disable_filetype = { "TelescopePrompt", "vim" },
                enable_check_bracket_line = false,
                ignored_next_char = "[%w%.#]"
            }

            require("cmp").event:on(
                "confirm_done",
                require("nvim-autopairs.completion.cmp").on_confirm_done()
            )
        end,
    },

    { "kylechui/nvim-surround" },

    { "numToStr/Comment.nvim" },

    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup {
                space_char_blankline = " ",
                show_current_context = true,
                show_current_context_start = true,
            }
        end
    },

    { "norcalli/nvim-colorizer.lua" },

    {
        -- "oahlen/iceberg.nvim",
        dir = "/home/oahlen/git/iceberg.nvim/",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("iceberg")
        end,
    },

    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup {
                signs = {
                    add          = { text = '+' },
                    change       = { text = '~' },
                    delete       = { text = '-' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = '┆' },
                },
            }
        end
    }
})
