local colorscheme = "gruvbox"
local cmd = vim.cmd

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	return
end

cmd([[ highlight Comment cterm=italic gui=italic ]])
