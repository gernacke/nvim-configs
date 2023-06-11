return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-project.nvim",
      "dhruvmanila/browser-bookmarks.nvim",
      "ahmedkhalf/project.nvim",
      "cljoly/telescope-repo.nvim",
      "stevearc/aerial.nvim",
      "nvim-telescope/telescope-frecency.nvim",
      "kkharji/sqlite.lua",
      "aaronhallaert/advanced-git-search.nvim",
      "benfowler/telescope-luasnip.nvim",
      "olacin/telescope-cc.nvim",
      "tsakirist/telescope-lazy.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-media-files.nvim",
      "nvim-lua/popup.nvim",
    },
    cmd = "Telescope",
    keys = {
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Grep CrnBuffer" },
      { "<leader>fB", "<cmd>lua require('utils.telescope').firefox_bookmarks()<cr>", desc = "Find Bookmarks" },
      { "<leader>vo", "<cmd>Telescope aerial<cr>", desc = "Code Outline" },
      { "<leader><space>", "<cmd>lua require('utils.telescope').project_files()<cr>", desc = "Find Files" },
      { "<leader>ff", "<cmd>lua require('utils.telescope').project_files()<cr>", desc = "Find Files" },
      { "<leader>fl", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      { "<leader>b<tab>", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
      { "<leader>f/", "<cmd>Telescope live_grep theme=ivy<cr>", desc = "Grep" },
      { "<leader>fM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>fC", "<cmd>Telescope colorscheme<cr>", desc = "Color Schemes" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
      { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>fK", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
      { "<leader>fH", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>fp", "<cmd>Telescope registers<cr>", desc = "Registers" },
      { "<leader>P", "<cmd>Telescope projects<CR>", desc = "List Projects" },
      { "<leader>zs", "<cmd>Telescope lazy<cr>", desc = "Search Plugins" },
    },
    config = function(_, _)
      local telescope = require "telescope"
      local icons = require "config.icons"
      local actions = require "telescope.actions"
      local actions_layout = require "telescope.actions.layout"
      local transform_mod = require("telescope.actions.mt").transform_mod
      local custom_actions = transform_mod {
        -- VisiData
        visidata = function(prompt_bufnr)
          -- Get the full path
          local content = require("telescope.actions.state").get_selected_entry()
          if content == nil then
            return
          end
          local full_path = content.cwd .. require("plenary.path").path.sep .. content.value

          -- Close the Telescope window
          require("telescope.actions").close(prompt_bufnr)

          -- Open the file with VisiData
          local utils = require "utils"
          utils.open_term("vd " .. full_path, { direction = "float" })
        end,

        -- File browser
        file_browser = function(prompt_bufnr)
          local content = require("telescope.actions.state").get_selected_entry()
          if content == nil then
            return
          end

          local full_path = content.cwd
          if content.filename then
            full_path = content.filename
          elseif content.value then
            full_path = full_path .. require("plenary.path").path.sep .. content.value
          end

          -- Close the Telescope window
          require("telescope.actions").close(prompt_bufnr)

          -- Open file browser
          -- vim.cmd("Telescope file_browser select_buffer=true path=" .. vim.fs.dirname(full_path))
          require("telescope").extensions.file_browser.file_browser { select_buffer = true, path = vim.fs.dirname(full_path) }
        end,
      }

      local mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
          ["?"] = actions_layout.toggle_preview,
          ["<C-s>"] = custom_actions.visidata,
          ["<C-i>"] = actions.to_fuzzy_refine,
          ["<A-f>"] = custom_actions.file_browser,
        },
        n = {
          ["s"] = custom_actions.visidata,
          ["<A-f>"] = custom_actions.file_browser,
          ["<C-f>"] = actions.results_scrolling_down,
          ["<C-b>"] = actions.results_scrolling_up,
        },
      }

      local opts = {
        defaults = {
          prompt_prefix = icons.ui.Telescope .. " ",
          selection_caret = icons.ui.Forward .. " ",
          mappings = mappings,
          border = {},
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          color_devicons = true,
          file_ignore_patterns = {
            ".git/",
          },
        },
        pickers = {
          -- find_files = {
          --   theme = "dropdown",
          --   previewer = false,
          --   hidden = true,
          --   find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
          -- },

          live_grep = {
            additional_args = function(opts)
              return { "--hidden" }
            end,
          },
          git_files = {
            theme = "dropdown",
            previewer = false,
          },
          buffers = {
            theme = "dropdown",
            previewer = false,
          },
        },
        extensions = {
          file_browser = {
            theme = "ivy",
            previewer = true,
            hijack_netrw = true,
            mappings = mappings,
          },
          bookmarks = {
            selected_browser = "firefox",
            url_open_command = "open",
            full_path = true,
            firefox_profile_name = nil,
          },
          project = {
            hidden_files = false,
            theme = "dropdown",
          },
          media_files = {
            -- filetypes whitelist
            -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
            filetypes = { "png", "webp", "jpg", "jpeg", "gif" },
            -- find command (defaults to `fd`)
            find_cmd = "rg",
          },
        },
      }
      telescope.setup(opts)
      telescope.load_extension "fzf"
      telescope.load_extension "file_browser"
      telescope.load_extension "project"
      telescope.load_extension "projects"
      telescope.load_extension "aerial"
      telescope.load_extension "dap"
      telescope.load_extension "frecency"
      telescope.load_extension "luasnip"
      telescope.load_extension "conventional_commits"
      telescope.load_extension "lazy"
      telescope.load_extension "media_files"
      telescope.load_extension "bookmarks"
    end,
  },
  {
    "stevearc/aerial.nvim",
    config = true,
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        detection_methods = { "pattern", "lsp" },
        patterns = {
          ".git",
          "_darcs",
          ".hg",
          ".bzr",
          ".svn",
          "Makefile",
          "package.json",
          "_root",
        },
        ignore_lsp = { "null-ls" },
      }
    end,
  },
}
