local status_ok, mason = pcall(require, "nvim-surround")
if not status_ok then
    return
end

mason.setup()
