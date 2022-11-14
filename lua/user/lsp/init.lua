local M = {}

local lsp_config = require("user.lsp.config")

function M.setup()
	local status_lspconfig_ok, _ = pcall(require, "lspconfig")
	if not status_lspconfig_ok then
		print("Missing lspconfig in user/lsp/init.lua")
		return
	end

	-- shouldn't need this.
	--[[ if lvim.use_icons then
    for _, sign in ipairs(lvim.lsp.diagnostics.signs.values) do
      vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
    end
  end ]]
	require("user.lsp.lsp-signature")
	require("user.lsp.mason_config")
	require("user.lsp.handlers").setup()
	require("user.lsp.null-ls")
end

return M
