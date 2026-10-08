-- Nix puts every plugin on the runtimepath at startup
if #vim.api.nvim_get_runtime_file("lua/lz/n/init.lua", false) > 0 then
    return
end

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
