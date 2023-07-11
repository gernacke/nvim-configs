local M = {}
-- TODO: investigate find files for git ignored files
local builtin = require("telescope.builtin")
local themes = require("telescope.themes")
local utils = require("telescope.utils")
local bookmarks = require("telescope").extensions.bookmarks

M.grep_zkfiles = function()
	builtin.live_grep(themes.get_ivy({
		prompt_title = "< Grep Zettelkasten >",
		prompt_prefix = "   ",
		results_title = "ZK Notes",
		path_display = { shorten = 3 },
		cwd = "$HOME/Library/CloudStorage/Dropbox/zettelkasten/",
	}))
end

M.firefox_bookmarks = function()
	bookmarks.bookmarks(themes.get_ivy())
end

M.grep_notes = function()
	builtin.live_grep(themes.get_ivy({
		prompt_title = "< Grep Notes >",
		prompt_prefix = "   ",
		path_display = { shorten = 3 },
		results_title = "Notes",
		cwd = "$HOME/Dropbox/notes/",
	}))
end

M.search_all_dotfiles = function()
	local opts = {}
	opts.prompt_title = "< Search All Dot Files >"
	opts.prompt_prefix = "﮷   "
	opts.hidden = true
	opts.results_title = "All Dot Files"
	opts.path_display = { shorten = 3 }
	-- opts.layout_strategy = "horizontal"
	-- opts.layout_config = { preview_width = 0.55, width = 0.85 }
	opts.cwd = "$HOME/repositories/all-dotfiles/"
	opts.file_ignore_patterns = {
		"nvim/",
		"nvim-legacy",
		"lunarVim",
	}

	builtin.find_files(opts)
end

M.search_nvim_configs = function()
	local opts = {}
	opts.prompt_title = "< Search Nvim Files >"
	opts.prompt_prefix = "   "
	opts.hidden = true
	opts.results_title = "Config Files"
	-- opts.path_display = { shorten = 3 }
	-- opts.layout_strategy = "horizontal"
	-- opts.layout_config = { preview_width = 0.55, width = 0.85 }
	opts.cwd = "$HOME/repositories/all-dotfiles/nvim/nvim/"
	opts.file_ignore_patterns = {
		".git/",
		".log",
		"Codeium/",
		".toml",
	}

	builtin.find_files(opts)
end

M.grep_nvim_configs = function()
	local opts = {}
	opts.prompt_title = "< Grep Nvim Files >"
	opts.prompt_prefix = "   "
	opts.results_title = "Search Results"
	opts.path_display = { shorten = 3 }
	opts.cwd = "$HOME/repositories/all-dotfiles/nvim/nvim/"
	builtin.live_grep(themes.get_ivy(opts))
end

M.search_sqlfiles = function()
	require("telescope.builtin").find_files({
		prompt_title = "  Search SQL Files",
		prompt_prefix = "﮷   ",
		layout_strategy = "horizontal",
		results_title = "SQL",
		layout_config = { preview_width = 0.55, width = 0.85 },
		cwd = "$HOME/Google Drive/My Drive/VScode/SQL-Queries/",
	})
end

M.grep_sqlfiles = function()
	local opts = {}
	opts.prompt_title = "< Grep All SQL Files >"
	opts.prompt_prefix = "   "
	opts.results_title = "Search Results"
	opts.cwd = "$HOME/Google Drive/My Drive/VScode/SQL-Queries/"
	builtin.live_grep(themes.get_ivy(opts))
end

M.search_notefiles = function()
	require("telescope.builtin").find_files({
		prompt_title = "  Search Note Files",
		prompt_prefix = "﮷   ",
		path_display = { shorten = 3 },
		layout_strategy = "horizontal",
		results_title = "Notes",
		layout_config = { preview_width = 0.55, width = 0.85 },
		cwd = "$HOME/Dropbox/notes/",
	})
end

M.grep_all_dotfiles = function()
	local opts = {}
	opts.prompt_title = "< Grep All Dot Files >"
	opts.prompt_prefix = "   "
	opts.results_title = "Search Results"
	opts.path_display = { shorten = 3 }
	opts.cwd = "$HOME/repositories/all-dotfiles/"
	builtin.live_grep(themes.get_ivy(opts))
end

M.project_files = function()
	local _, ret, stderr = utils.get_os_command_output({
		"git",
		"rev-parse",
		"--is-inside-work-tree",
	})

	local gopts = {}
	local fopts = {}

  fopts.layout_strategy = "horizontal"
  fopts.layout_config = { height = 0.8 }

	fopts.prompt_title = " Find"
	fopts.prompt_prefix = "  "
	gopts.results_title = "  Repo Files"

	fopts.hidden = true
  fopts.no_ignore = true
	fopts.file_ignore_patterns = {
		".vim/",
		".local/",
		".cache/",
		"Downloads/",
		".git/",
		"Dropbox/.*",
		"Library/.*",
		".rustup/.*",
		"Movies/",
		".cargo/registry/",
		"_root",
		"nvim/",
		"nvim-legacy/",
	}
	fopts.results_title = "CWD: " .. vim.fn.getcwd()

	builtin.find_files(fopts)
	-- if ret == 0 then
	--   builtin.git_files(gopts)
	-- else
	--   fopts.results_title = "CWD: " .. vim.fn.getcwd()
	--   builtin.find_files(fopts)
	-- end
end

return M
