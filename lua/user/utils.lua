local M = {}

function M.smart_quit()
	local bufnr = vim.api.nvim_get_current_buf()
	local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
	if modified then
		vim.ui.input({ prompt = "You have unsaved changes. Quit anyway? (y/n) " }, function(input)
			if input == "y" then
				vim.cmd("q!")
			end
		end)
	else
		vim.cmd("q!")
	end
end

function M.isempty(s)
	return s == nil or s == ""
end

function M.get_buf_option(opt)
	local status_ok, buf_option = pcall(vim.api.nvim_buf_get_option, 0, opt)
	if not status_ok then
		return nil
	else
		return buf_option
	end
end

function M.setup_document_symbols(client, bufnr)
	vim.g.navic_silence = false -- can be set to true to suppress error
	local symbols_supported = client.supports_method("textDocument/documentSymbol")

	if not symbols_supported then
		print("skipping setup for document_symbols, method not supported by " .. client.name)
		return
	end
	local status_ok, navic = pcall(require, "nvim-navic")
	if status_ok then
		navic.attach(client, bufnr)
	end
end

return M
