local M = {}

function M.setup()
    local status_lspconfig_ok, _ = pcall(require, "lspconfig")
    if not status_lspconfig_ok then
        print("Missing lspconfig in user/lsp/init.lua")
        return
    end

    require("user.lsp.lsp-signature")
    require("user.lsp.mason_config")
    require("user.lsp.handlers").setup()
    require("user.lsp.null-ls")
end

local l_status_ok, lsp_lines = pcall(require, "lsp_lines")
if not l_status_ok then
    return
end

lsp_lines.setup()

return M
