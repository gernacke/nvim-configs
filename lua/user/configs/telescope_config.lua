local M = {}

-- WIP make the buffer list delete to use :Bdelete, actions.delete_buffer({prompt_bufnr})
function M.setup()
  -- Loading extensions
  require("telescope").load_extension("fzf")
  require("telescope").load_extension("bookmarks")
  require("telescope").load_extension("frecency")
  require("telescope").load_extension("file_browser")

  local browser = require("telescope").extensions.file_browser
  local fb_actions = require("telescope").extensions.file_browser.actions
  local bookmarks = require("telescope").extensions.bookmarks
  local actions = require("telescope.actions")
  local transform_mod = require("telescope.actions.mt").transform_mod
  local builtin = require("telescope.builtin")
  local themes = require("telescope.themes")
  local utils = require("telescope.utils")

  -- TODO browse through telescope functions from codesmells repo
  M.browse_nvim_configs = function()
    require("telescope").extensions.file_browser.file_browser({
      prompt_title = " Browse Configs",
      prompt_prefix = "﮷   ",
      cwd = "~/.config/nvim/",
      layout_strategy = "horizontal",
      layout_config = { preview_width = 0.65, width = 0.75 },
    })
  end

  M.search_dotfiles = function()
    require("telescope.builtin").find_files({
      prompt_title = "< Search Nvim Config Files >",
      prompt_prefix = " ﮷   ",
      results_title = "Nvim Config Files",
      path_display = { shorten = 3 },
      layout_strategy = "horizontal",
      layout_config = { preview_width = 0.65, width = 0.75 },
      cwd = "$HOME/repositories/all-dotfiles/nvim/",
    })
  end

  M.grep_dotfiles = function()
    builtin.live_grep(themes.get_ivy({
      prompt_title = "< Grep Nvim Configs >",
      prompt_prefix = "    ",
      results_title = "Nvim Config Files",
      path_display = { shorten = 3 },
      cwd = "$HOME/repositories/all-dotfiles/nvim/",
    }))
  end

  M.search_neorgfiles = function()
    require("telescope.builtin").find_files({
      prompt_title = "  Find Neorg Files",
      prompt_prefix = " ﮷   ",
      results_title = "Neorg Files",
      path_display = { shorten = 3 },
      layout_strategy = "horizontal",
      layout_config = { preview_width = 0.65, width = 0.75 },
      cwd = "$HOME/repositories/Neorg/",
    })
  end

  M.search_neorg = function()
    builtin.live_grep(themes.get_ivy({
      prompt_title = "< Grep Neorg >",
      prompt_prefix = "    ",
      results_title = "Neorg Files",
      path_display = { shorten = 3 },
      cwd = "$HOME/repositories/Neorg/",
    }))
  end

  M.search_notes = function()
    builtin.live_grep(themes.get_ivy({
      prompt_title = "< Grep Notes >",
      prompt_prefix = "    ",
      path_display = { shorten = 3 },
      results_title = "Notes",
      cwd = "$HOME/repositories/notes/",
    }))
  end

  M.search_notefiles = function()
    require("telescope.builtin").find_files(themes.get_ivy({
      prompt_title = "  Search Note Files",
      prompt_prefix = " ﮷   ",
      path_display = { shorten = 3 },
      layout_strategy = "horizontal",
      results_title = "Notes",
      layout_config = { preview_width = 0.65, width = 0.75 },
      cwd = "~/repositories/notes/",
    }))
  end

  M.project_files = function()
    local _, ret, stderr = utils.get_os_command_output({
      "git",
      "rev-parse",
      "--is-inside-work-tree",
    })

    local gopts = {}
    local fopts = {}

    gopts.prompt_title = " Find"
    gopts.prompt_prefix = "   "
    gopts.results_title = "  Repo Files"

    fopts.hidden = true
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
    }

    if ret == 0 then
      builtin.git_files(gopts)
    else
      fopts.results_title = "CWD: " .. vim.fn.getcwd()
      builtin.find_files(fopts)
    end
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
  -- grep_string pre-filtered from grep_prompt
  local function grep_filtered(opts)
    opts = opts or {}
    require("telescope.builtin").grep_string({
      path_display = { "smart" },
      search = opts.filter_word or "",
    })
  end

  -- open vim.ui.input dressing prompt for initial filter
  M.grep_prompt = function()
    vim.ui.input({ prompt = "Rg " }, function(input)
      grep_filtered({ filter_word = input })
    end)
  end

  -- Creating custom actions
  local custom_actions = {}
  function custom_actions.test1()
    M.project_files()
  end

  custom_actions = transform_mod(custom_actions)

  -- Set up telescope
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
          ["<C-i>"] = actions.to_fuzzy_refine,
          ["<M-j>"] = actions.which_key,
        },
        n = {
          ["<C-f>"] = actions.results_scrolling_down,
          ["<C-b>"] = actions.results_scrolling_up,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["l"] = custom_actions.test1,
        },
      },
    },
  })
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
