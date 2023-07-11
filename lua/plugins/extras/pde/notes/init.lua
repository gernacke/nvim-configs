return {
	{
		"dhruvasagar/vim-table-mode",
		ft = { "markdown", "org", "norg" },
		keys = {
			{ "<leader>tm", desc = "Toggle Table Mode" },
			{ "<leader>tt", mode = "v", desc = "Tableize" },
			{ "<leader>tdc", desc = "Delete Table Column" },
			{ "<leader>tdd", desc = "Delete Table Row" },
			{ "<leader>tic", desc = "Insert Column After" },
			{ "<leader>tiC", desc = "Insert Column Before" },
		},
	},
	-- {
	-- 	"lukas-reineke/headlines.nvim",
	-- 	opts = {
	-- 		markdown = {
	-- 			fat_headline_lower_string = "▔",
	-- 		},
	-- 	},
	-- 	config = true,
	-- 	ft = { "markdown", "org", "norg" },
	-- },
	{
		"frabjous/knap",
		init = function()
			-- Configure vim.g.knap_settings
		end,
    --stylua: ignore
    keys = {
      { "<leader>np", function() require("knap").process_once() end, desc = "Preview", },
      { "<leader>nc", function() require("knap").close_viewer() end, desc = "Close Preview", },
      { "<leader>nt", function() require("knap").close_viewer() end, desc = "Toggle Preview", },
      { "<leader>nj", function() require("knap").forward_jump() end, desc = "Forward jump", },
    },
		ft = { "markdown", "tex" },
	},
}
