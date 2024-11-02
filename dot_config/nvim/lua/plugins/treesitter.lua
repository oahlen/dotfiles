return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = {
                    "angular",
                    "bash",
                    "c",
                    "cmake",
                    "comment",
                    "c_sharp",
                    "css",
                    "csv",
                    "dockerfile",
                    "fish",
                    "gitattributes",
                    "gitcommit",
                    "git_config",
                    "gitignore",
                    "git_rebase",
                    "go",
                    "helm",
                    "html",
                    "java",
                    "javascript",
                    "json",
                    "kotlin",
                    "lua",
                    "make",
                    "markdown_inline",
                    "nix",
                    "pem",
                    "proto",
                    "python",
                    "query",
                    "regex",
                    "rust",
                    "scss",
                    "sql",
                    "svelte",
                    "tmux",
                    "toml",
                    "typescript",
                    "vim",
                    "vimdoc",
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
    }
}
