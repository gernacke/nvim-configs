return {
	{
		"chrisgrieser/nvim-various-textobjs",
		config = function()
			require("various-textobjs").setup({ useDefaultKeymaps = true, lookForwardSmall = 50, lookForwardBig = 50 })
		end,
		event = "VeryLazy",
		enabled = true,
	},
	{ "axieax/urlview.nvim", enabled = false, cmd = { "UrlView" } },
}
