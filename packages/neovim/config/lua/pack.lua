-- Nix puts every plugin on the runtimepath at startup
if #vim.api.nvim_get_runtime_file("lua/lz/n/init.lua", false) > 0 then
    return
end

-- Neovim instance is managed with vim.pack, run `:lua vim.pack.update()` to keep them updated
local file = vim.fs.joinpath(vim.fn.stdpath("config"), "plugins.json")
local plugins = vim.json.decode(table.concat(vim.fn.readfile(file), "\n"))

local specs = vim.iter(plugins)
    :map(function(plugin)
        return {
            name = plugin.name,
            src = plugin.src,
            version = plugin.version and vim.version.range(plugin.version),
        }
    end)
    :totable()

-- Only install, lz.n loads the plugins that have a spec
vim.pack.add(specs, { confirm = false, load = function() end })

for _, plugin in ipairs(plugins) do
    if plugin.start then
        vim.cmd.packadd(plugin.name)
    end
end

-- Without nix, we install language servers and tools through mason
vim.pack.add({ "https://github.com/mason-org/mason.nvim" }, { confirm = false })
require("mason").setup()

-- Without nix, parsers are compiled by nvim-treesitter (requires the tree-sitter CLI and a C compiler)
vim.pack.add({ { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" } }, { confirm = false })
local parsers = vim.fs.joinpath(vim.fn.stdpath("config"), "parsers.json")

if vim.fn.executable("tree-sitter") == 1 then
    require("nvim-treesitter").install(vim.json.decode(table.concat(vim.fn.readfile(parsers), "\n")))
else
    vim.notify("tree-sitter CLI not found, skipping parser install", vim.log.levels.WARN)
end
