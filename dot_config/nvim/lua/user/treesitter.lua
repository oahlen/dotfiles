local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

configs.setup {
    ensure_installed = {
        "bash",
        "c",
        "c_sharp",
        "cmake",
        "comment",
        "css",
        "dockerfile",
        "fish",
        "gitignore",
        "go",
        "help",
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
