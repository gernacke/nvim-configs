local status_lspconfig_ok, _ = pcall(require, "lspconfig")
if not status_lspconfig_ok then
    print("Missing lspconfig in user/lsp/init.lua")
    return
end

require("user.lsp.mason_config")
require("user.lsp.handlers").setup()
require("user.lsp.null-ls")
