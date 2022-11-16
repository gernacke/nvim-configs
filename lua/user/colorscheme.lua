local M = {}

local api = vim.api
local colorscheme = "gruvbox"
local cmd = vim.cmd

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	return
end

cmd([[ highlight Comment cterm=italic gui=italic ]])

-- vim.api.nvim_set_hl(0, "NavicText",                {fg = "#F07178"})
-- vim.api.nvim_set_hl(0, "NavicIconsNull",           {fg = "#F07178"})
-- vim.api.nvim_set_hl(0, "NavicIconsEnumMember",     {fg = "#F07178"})
-- vim.api.nvim_set_hl(0, "NavicIconsStruct",         {fg = "#F07178"})
-- vim.api.nvim_set_hl(0, "NavicIconsEvent",          {fg = "#F07178"})
-- vim.api.nvim_set_hl(0, "NavicIconsOperator",       {fg = "#F07178"})
-- vim.api.nvim_set_hl(0, "NavicIconsTypeParameter",  {fg = "#F07178"})
-- vim.api.nvim_set_hl(0, "NavicText",                {fg = "#F07178"})
-- vim.api.nvim_set_hl(0, "NavicSeparator",           {fg = "#F07178"})

local hl_mappings = {
	["NavicIconsFile"]        = { fg = "#eeac50" },
	["NavicIconsModule"]      = { fg = "#CFD8DC" },
	["NavicIconsNamespace"]   = { fg = "#60b5cc" },
	["NavicIconsPackage"]     = { fg = "#FF9800" },
	["NavicIconsClass"]       = { fg = "#D67E00" },
	["NavicIconsMethod"]      = { fg = "#652D90" },
	["NavicIconsProperty"]    = { fg = "#428ff5" },
	["NavicIconsField"]       = { fg = "#007ACC" },
	["NavicIconsConstructor"] = { fg = "#fce444" },
	["NavicIconsEnum"]        = { fg = "#D67E00" },
	["NavicIconsInterface"]   = { fg = "#007ACC" },
	["NavicIconsFunction"]    = { fg = "#E51400" },
	["NavicIconsVariable"]    = { fg = "#007ACC" },
	["NavicIconsConstant"]    = { fg = "#044c84" },
	["NavicIconsString"]      = { fg = "#1e7a29" },
	["NavicIconsNumber"]      = { fg = "#1e7a29" },
	["NavicIconsBoolean"]     = { fg = "#cfba95" },
	["NavicIconsArray"]       = { fg = "#58897b" },
	["NavicIconsObject"]      = { fg = "#a6d1ca" },
	["NavicIconsKey"]         = { fg = "#045594" },
}

function M.setup()
	for k, v in pairs(hl_mappings) do
		api.nvim_set_hl(0, k, v)
	end
end

M.setup()
