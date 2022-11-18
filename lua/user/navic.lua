local M = {}

local api = vim.api
local status_ok, navic = pcall(require, "nvim-navic")
if not status_ok then
	return
end

local icons = require("user.icons")

navic.setup({
	icons = {
		File = " ",
		Module = " ",
		Namespace = " ",
		Package = " ",
		Class = " ",
		Method = "m ",
		Property = " ",
		Field = " ",
		Constructor = " ",
		Enum = " ",
		Interface = "練",
		Function = " ",
		Variable = " ",
		Constant = " ",
		String = " ",
		Number = " ",
		Boolean = "◩ ",
		Array = " ",
		Object = " ",
		Key = " ",
		Null = "ﳠ ",
		EnumMember = " ",
		Struct = " ",
		Event = " ",
		Operator = " ",
		TypeParameter = " ",
	},
	highlight = true,
	separator = " " .. icons.ui.ChevronRight .. " ",
	depth_limit = 0,
	depth_limit_indicator = "..",
})

local hl_mappings = {
    -- ["NavicText"]= ""
	["NavicIconsFile"]          = { fg = "#eeac50" },
	["NavicIconsModule"]        = { fg = "#CFD8DC" },
	["NavicIconsNamespace"]     = { fg = "#60b5cc" },
	["NavicIconsPackage"]       = { fg = "#FF9800" },
	["NavicIconsClass"]         = { fg = "#D67E00" },
	["NavicIconsMethod"]        = { fg = "#652D90" },
	["NavicIconsProperty"]      = { fg = "#428ff5" },
	["NavicIconsField"]         = { fg = "#007ACC" },
	["NavicIconsConstructor"]   = { fg = "#fce444" },
	["NavicIconsEnum"]          = { fg = "#D67E00" },
	["NavicIconsInterface"]     = { fg = "#007ACC" },
	["NavicIconsFunction"]      = { fg = "#E51400" },
	["NavicIconsVariable"]      = { fg = "#007ACC" },
	["NavicIconsConstant"]      = { fg = "#044c84" },
	["NavicIconsString"]        = { fg = "#1e7a29" },
	["NavicIconsNumber"]        = { fg = "#1e7a29" },
	["NavicIconsBoolean"]       = { fg = "#cfba95" },
	["NavicIconsArray"]         = { fg = "#58897b" },
	["NavicIconsObject"]        = { fg = "#a6d1ca" },
	["NavicIconsKey"]           = { fg = "#045594" },
	["NavicIconsNull"]          = { fg = "#F07178" },
	["NavicIconsEnumMember"]    = { fg = "#007ACC" },
	["NavicIconsStruct"]        = { fg = "#424242" },
	["NavicIconsEvent"]         = { fg = "#D67E00" },
	["NavicIconsOperator"]      = { fg = "#414141" },
	["NavicIconsTypeParameter"] = { fg = "#F57C00" },
	-- ["NavicSeparator"]          = { fg = "#FFAB91" },
}

function M.set_hl()
	for k, v in pairs(hl_mappings) do
		api.nvim_set_hl(0, k, v)
	end
end

M.set_hl()
