-- only attach, starting is done manually
-- this is required when a new buffer is opened for system definitions
if #vim.lsp.get_clients({ name = "jdtls" }) > 0 then
    require("plugins.lsp.config.java").start()
end