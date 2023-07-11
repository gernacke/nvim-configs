return {
	{
		"SmiteshP/nvim-navbuddy",
		event = "VeryLazy",
		dependencies = {
			"neovim/nvim-lspconfig",
			"SmiteshP/nvim-navic",
			"MunifTanjim/nui.nvim",
		},
    --stylua: ignore
    keys = {
      { "<leader>vO", function() require("nvim-navbuddy").open() end, desc = "Code Outline (navbuddy)", },
    },
		opts = {},
		config = function()
			local lsp_utils = require("plugins.lsp.utils")
			lsp_utils.on_attach(function(client, buffer)
				if client.name ~= "null-ls" then
					local navbuddy = require("nvim-navbuddy")
					if client.server_capabilities.documentSymbolProvider then
						navbuddy.setup({
							window = {
								border = "rounded", -- "rounded", "double", "solid", "none"
								-- or an array with eight chars building up the border in a clockwise fashion
								-- starting with the top-left corner. eg: { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }.
								size = "70%", -- Or table format example: { height = "40%", width = "100%"}
							},
							icons = {
								File = " ", -- File
								Module = " ", -- Module
								Namespace = " ", -- Namespace
								Package = " ", -- Package
								Class = " ", -- Class
								Method = "m ", -- Method
								Property = " ", -- Property
								Field = " ", -- Field
								Constructor = " ", -- Constructor
								Enum = "", --  Enum
								Interface = "練", --  Interface
								Function = " ", -- Function
								Variable = " ", -- Variable
								Constant = " ", -- Constant
								String = " ", -- String
								Number = " ", -- Number
								Boolean = "◩ ", -- Boolean
								Array = " ", -- Array
								Object = " ", -- Object
								Key = " ", -- Key
								Null = "ﳠ ", -- Null
								EnumMember = " ", -- EnumMember
								Struct = " ", -- Struct
								Event = " ", -- Event
								Operator = " ", -- Operator
								TypeParameter = " ", -- TypeParameter
								Macro = " ", -- Macro
							},
						})

						navbuddy.attach(client, buffer)
					end
				end
			end)
		end,
	},
}
