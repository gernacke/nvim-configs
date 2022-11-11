local M = {}

function M.setup()
    require("telescope").load_extension "fzf"
    require("telescope").load_extension "project"

    local actions = require "telescope.actions"

    require("telescope").setup {
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
            arecibo = {
                ["selected_engine"] = "google",
                ["url_open_command"] = "xdg-open",
                ["show_http_headers"] = false,
                ["show_domain_icons"] = false,
            },
            fzf = {
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
        },
        defaults = {
            mappings = {
                i = {
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                    ["<C-n>"] = actions.cycle_history_next,
                    ["<C-p>"] = actions.cycle_history_prev,
                },
            },
        },
    }

    require("telescope").load_extension "bookmarks"
    require("telescope").load_extension "zoxide"
    require("telescope").load_extension "frecency"
    require("telescope").load_extension "file_browser"
    -- TODO integrate hop to telescope
    -- require('telescope').load_extension('snippets')
    -- require("telescope").load_extension "neoclip"
    -- require("telescope").load_extension "gkeep"
    -- require("telescope").load_extension "ultisnips"
    -- require("telescope").load_extension "repo"
    -- require("telescope").load_extension "gh"

    -- TODO build more telescope functions
    M.search_dotfiles = function()
        require("telescope.builtin").find_files {
            prompt_title = "< all-dotfiles >",
            cwd = "$HOME/repositories/all-dotfiles/",
        }
    end

    M.switch_projects = function()
        require("telescope.builtin").find_files {
            prompt_title = "< Switch Project >",
            cwd = "$HOME/repositories/",
        }
    end

    M.git_branches = function()
        require("telescope.builtin").git_branches {
            attach_mappings = function(prompt_bufnr, map)
                map("i", "<c-d>", actions.git_delete_branch)
                map("n", "<c-d>", actions.git_delete_branch)
                return true
            end,
        }
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
