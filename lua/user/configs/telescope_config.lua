local M = {}

-- TODO add an action to move up and down N lines of results :help telescope.actions.set
-- TODO make the buffer list delete to use :Bdelete
function M.setup()
	require("telescope").load_extension("fzf")
	-- require("telescope").load_extension "project"
	local browser = require("telescope").extensions.file_browser
	local fb_actions = require("telescope").extensions.file_browser.actions
	local bookmarks = require("telescope").extensions.bookmarks
	local actions = require("telescope.actions")
	-- local action_set = require("telescope.actions.set")
	local builtin = require("telescope.builtin")
	local themes = require("telescope.themes")

	require("telescope").setup({
		find_command = {
			"rg",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		use_less = true,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = false,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
			media_files = {
				filetypes = { "png", "jpg", "mp4", "webm", "pdf", "gif" },
			},
			bookmarks = {
				selected_browser = "firefox",
				url_open_command = "open",
				full_path = true,
				firefox_profile_name = nil,
			},
			file_browser = {
				theme = "ivy",
				mappings = {
					["n"] = {
						["a"] = fb_actions.toggle_all,
						["n"] = fb_actions.create,
						["r"] = fb_actions.rename,
						["v"] = fb_actions.move,
						["p"] = fb_actions.copy,
						["d"] = fb_actions.remove,
						["."] = fb_actions.toggle_hidden,
						["t"] = fb_actions.sort_by_date,
						["h"] = fb_actions.goto_parent_dir,
					},
				},
				respect_gitignore = false,
			},
		},
		pickers = {
			buffers = { theme = "dropdown", previewer = false },
			lsp_document_symbols = { theme = "ivy" },
		},
		defaults = {
			mappings = {
				i = {
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
                    -- ["<M-J>"] = action_set.scroll_results(0, "descending"),
                    -- ["<M-K>"] = action_set.scroll_results(0, "ascending"),
					["<C-n>"] = actions.cycle_history_next,
					["<C-p>"] = actions.cycle_history_prev,
				},
				n = {
					["<C-f>"] = actions.results_scrolling_down,
					["<C-b>"] = actions.results_scrolling_up,
					["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				},
			},
		},
	})

	require("telescope").load_extension("bookmarks")
	require("telescope").load_extension("frecency")
	require("telescope").load_extension("file_browser")
	-- require('telescope').load_extension('snippets')
	-- require("telescope").load_extension "neoclip"
	-- require("telescope").load_extension "gkeep"
	-- require("telescope").load_extension "ultisnips"
	-- require("telescope").load_extension "repo"
	-- require("telescope").load_extension "gh"

	M.search_dotfiles = function()
		require("telescope.builtin").find_files({
			prompt_title = "< search nvim config files >",
			cwd = "$HOME/repositories/all-dotfiles/nvim/",
		})
	end

	M.search_neorg = function()
		builtin.live_grep({
			prompt_title = "< grep Neorg files >",
			cwd = "$HOME/repositories/Neorg/",
		})
	end

	M.search_notes = function()
		builtin.live_grep({
			prompt_title = "< grep notes files >",
			cwd = "$HOME/repositories/notes/",
		})
	end

	M.grep_dotfiles = function()
		builtin.live_grep({
			prompt_title = "< grep nvim config files >",
			cwd = "$HOME/repositories/all-dotfiles/nvim/",
		})
	end

	M.switch_projects = function()
		builtin.find_files({
			prompt_title = "< Switch Project >",
			cwd = "$HOME/repositories/",
		})
	end

	M.git_branches = function()
		builtin.git_branches({
			attach_mappings = function(prompt_bufnr, map)
				map("n", "<c-d>", actions.git_delete_branch)
				return true
			end,
		})
	end

	M.file_browser = function()
		browser.file_browser()
	end

	M.switch_buffers = function()
		builtin.buffers({
			attach_mappings = function(prompt_bufnr, map)
				map("n", "d", actions.delete_buffer)
				map("i", "<C-d>", actions.delete_buffer)
				return true
			end,
		})
	end

	M.workspace_symbols = function()
		builtin.lsp_dynamic_workspace_symbols()
	end

	M.document_symbols = function()
		builtin.lsp_document_symbols()
	end

	M.firefox_bookmarks = function()
		bookmarks.bookmarks(themes.get_ivy())
	end
end

return M

--[[
-- MORE FILE_BROWSER MAPPINGS
Insert / Normal 	fb_actions 	Description
<A-c>/c 	create          Create file/folder at current path (trailing path separator creates folder)
<S-CR> create_from_prompt   Create and open file/folder from prompt (trailing path separator creates folder)
<A-r>/r 	rename          Rename multi-selected files/folders
<A-m>/m 	move            Move multi-selected files/folders to current path
<A-y>/y 	copy            Copy (multi-)selected files/folders to current path
<A-d>/d 	remove          Delete (multi-)selected files/folders
<C-o>/o 	open            Open file/folder with default system application
<C-g>/g 	goto_parent_dir Go to parent directory
<C-e>/e 	goto_home_dir   Go to home directory
<C-w>/w 	goto_cwd        Go to current working directory (cwd)
<C-t>/t 	change_cwd      Change nvim's cwd to selected folder/file(parent)
<C-f>/f 	toggle_browser  Toggle between file and folder browser
<C-h>/h 	toggle_hidden   Toggle hidden files/folders
<C-s>/s 	toggle_all      Toggle all entries ignoring ./ and ../
<Tab> 	see               telescope.nvim 	Toggle selection and move to next selection
<S-Tab> 	see             telescope.nvim 	Toggle selection and move to prev selection
]]
