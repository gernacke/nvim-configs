return {
  -- {
  --   "catppuccin/nvim",
  --   priority = 1000,
  --   opts = {
  --     transparent_background = false,
  --     integrations = {
  --       cmp = true,
  --       gitsigns = true,
  --       nvimtree = true,
  --       -- telescope = true,
  --     },
  --     -- dim_inactive = {
  --     --   enabled = true,
  --     --   shade = "dark",
  --     --   percentage = 0.01,
  --     -- },
  --   },
  --   config = function(_, opts)
  --     local catppuccin = require "catppuccin"
  --     catppuccin.setup(opts)
  --     -- load the colorscheme here
  --     -- vim.cmd [[colorscheme catppuccin-mocha]]
  --     vim.cmd [[colorscheme catppuccin-macchiato]]
  --   end,
  -- },
  "nvim-lua/plenary.nvim",
  -- { "christoomey/vim-tmux-navigator", keys = { "<C-j>", "<C-k>", "<C-h>", "<C-l>" } },
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "godlygeek/tabular",
  "nvim-lua/popup.nvim",
  "ckipp01/stylua-nvim",
  "moll/vim-bbye",
  "neovim/nvim-lspconfig",
  "mortepau/codicons.nvim",
  { "junegunn/vim-easy-align", lazy = false },
  {
    "romainl/vim-devdocs",
    keys = {
      { "<leader>cd", "<cmd>DD<cr>", desc = "Search in DevDocs.io" },
    },
  },
  "preservim/vim-markdown",
  {
    "tpope/vim-dotenv",
    config = function()
      vim.cmd([[ Dotenv ~/.config/nvim/DBUI.env ]])
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatorProcessList",
    },
  },
  { "tpope/vim-repeat", event = "VeryLazy" },

  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup()
      --            vim.cmd [[colorscheme gruvbox]]
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    -- dependencies = { "DaikyXendo/nvim-material-icon" },
    config = function()
      require("nvim-web-devicons").setup({
        override_by_extension = {
          ["log"] = {
            icon = "",
            color = "#81e043",
            name = "Log",
          },
          -- ["toml"] = {
          --   icon = "󰬛",
          --   color = "#81e043",
          --   name = "toml",
          -- },
        },
      })
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
        { path = "lazy.nvim", words = { "LazyVim" } },
      },
    },
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = false },
      dashboard = { enabled = false },
      explorer = { enabled = false },
      indent = {
        priority = 1,
        enabled = true,
        char = "│",
        animate = {
          priority = 1,
          enabled = vim.fn.has("nvim-0.10") == 1,
          style = "out",
          easing = "linear",
          duration = {
            step = 5, -- ms per step
            total = 80, -- maximum duration
          },
        },
      },
      input = { enabled = true },
      lazygit = { enabled = true },
      picker = {
        enabled = true,
        ui_select = true, -- replace `vim.ui.select` with the snacks picker
        win = {
          -- input window
          input = {
            keys = {
              -- to close the picker on ESC instead of going to normal mode,
              -- add the following keymap to your config
              -- ["<Esc>"] = { "close", mode = { "n", "i" } },
              ["<c-x>"] = { "edit_split", mode = { "i", "n" } },
            },
          },
        },
      },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = true },
      words = { enabled = false },
      zen = {
        toggles = {
          dim = false,
          git_signs = true,
          mini_diff_signs = true,
        },
        win = { style = "zen", width = 180 },
        show = {
          statusline = true, -- can only be shown when using the global statusline
          tabline = true,
        },
      },
    },
    -- stylua: ignore
    keys = {
      -- Top Pickers & Explorer
      { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files", },
      { "<leader><tab>", function() Snacks.picker.buffers() end, desc = "Buffers", },
      { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep", },
      { "<leader>;", function() Snacks.picker.command_history() end, desc = "Command History", },
      { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History", },
      -- Find
      { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<leader>fe", function() Snacks.explorer() end, desc = "File Explorer", },
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
      { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
      { "<leader>fl", function() Snacks.picker.recent() end, desc = "Recent", },
      { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
      { "<leader>fq", function() Snacks.picker.files({
        cwd = os.getenv('HOME') .. "/sqlqueries/",
        prompt = " 󱘲 SQL Query 󰅂 ",
      }) end, desc = "Find SQL Queries" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
      { "<leader>fs", function() Snacks.scratch.select() end, desc = "Find Scratch Buffer", },
      { "<leader>fw", function() Snacks.picker.spelling() end, desc = "Find Word Spelling", },
      { "<leader>fz", function() Snacks.picker.zoxide() end, desc = "Find in Zoxide", },

      { "<leader>fd",
        function() Snacks.picker.files({ 
          cwd = os.getenv('HOME') .. "/repositories/all-dotfiles/",
          prompt = " 󱁼 Find Dot File 󰅂 ",
          finder = "files",
          format = "file",
          show_empty = true,
          hidden = true,
          follow = true,
          untracked = false,
          exclude = { "*.glsl", "nvim/", "nvim-legacy/" },
        }) end,
      desc = "Find Dot File" },
      -- Git
      { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
      { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
      { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
      { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },

      -- Grep & Search
      { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines", },
      { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers", },
      { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" }, },

      { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
      { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
      { "<leader>sD",
        function() Snacks.picker.git_grep({
          cwd = os.getenv('HOME') .. "/repositories/all-dotfiles/",
          prompt = " 󱁼 Grep Dot File 󰅂 ",
          finder = "git_grep",
          untracked = false,
          need_search = true,
          submodules = false,
          regex = true,
          show_empty = true,
          live = true,
          supports_live = true,
        }) end,
      desc = "Grep Dot File" },
      { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
      { "<leader>sc",
        function() Snacks.picker.git_grep({
          cwd = vim.fn.stdpath("config"),
          prompt = "  Grep Configs 󰅂 ",
          finder = "git_grep",
          untracked = true,
          need_search = true,
          submodules = false,
          regex = true,
          show_empty = true,
          live = true,
          supports_live = true,
        }) end,
      desc = "Grep Dot File" },
      { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
      { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
      { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
      { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
      { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
      { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
      { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
      { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
      { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
      { "<leader>sQ", function() Snacks.picker.grep({
        cwd = os.getenv('HOME') .. "/sqlqueries/",
        prompt = " 󱘲 SQL Query 󰅂 ",
      }) end, desc = "Grep", },
      { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
      { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
      { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
      { "<leader>sT", function() Snacks.picker.todo_comments() end, desc = "Todo" },
      { "<leader>st", function () Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
      -- Zen mode
      { "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer", },
      { "<leader>bo", function() Snacks.bufdelete() end, desc = "Delete Buffer", },
      { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File", },

      -- LSP
      { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
      { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
      { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },

      {
        "<leader>N",
        desc = "Neovim News",
        function()
          Snacks.win({
            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = "yes",
              statuscolumn = " ",
              conceallevel = 3,
            },
          })
        end,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.line_number():map("<leader>ul")
          Snacks.toggle
            .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
            :map("<leader>uc")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
          Snacks.toggle.inlay_hints():map("<leader>uh")
          Snacks.toggle.indent():map("<leader>ug")
          Snacks.toggle.dim():map("<leader>uD")
        end,
      })
    end,
  },
  {
    "shortcuts/no-neck-pain.nvim",
    lazy = false,
    version = "*",
    opts = {
      width = 110,
      buffers = {
        -- right = {
        --   enabled = false,
        -- },
        -- colors = {
        --   -- background = "onedark", -- you can use hex colors here
        --   blend = 0.5,
        -- },
      },
      integrations = {
        NvimTree = {
          position = "left",
        },
      },
      -- autocmds = {
      --   enableOnVimEnter = true,
      -- },
    },
    keys = {
      { "<leader>vn", ":NoNeckPain<CR>", desc = "Toggle No Neck Pain" },
    },
  },
  {
    "andymass/vim-matchup",
    event = { "BufReadPost" },
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "status" }
    end,
  },
  { "tpope/vim-surround", event = "BufReadPre" },
  {
    "onsails/lspkind-nvim",
    config = function()
      require("lspkind").init()
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      { "<leader>fo", "<cmd>Trouble symbols<cr>", desc = "Symbols Outline" },
    },
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup({
        modes = {
          symbols = {
            desc = "document symbols",
            mode = "lsp_document_symbols",
            focus = true,
            win = { position = "right" },
            filter = {
              -- remove Package since luals uses it for control flow structures
              ["not"] = { ft = "lua", kind = "Package" },
            },
          },
        },
      })
    end,
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
  },
  "MunifTanjim/nui.nvim",
  { "nacro90/numb.nvim", event = "BufReadPre", config = true },
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   enabled = true,
  --   event = "BufReadPre",
  --   config = function()
  --     require("ibl").setup({
  --       indent = { char = "▏" },
  --       scope = {
  --         -- Shows an underline on the first line of the scope
  --         show_start = false,
  --       },
  --     })
  --   end,
  -- },
  -- {
  --   "nvimdev/indentmini.nvim",
  --   event = "BufEnter",
  --   config = function()
  --     require("indentmini").setup({
  --       char = "|",
  --       exclude = {
  --         "erlang",
  --         "markdown",
  --       },
  --     })
  --   end,
  -- },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker").setup({
        disable_legacy_commands = true,
      })
    end,
    keys = {
      { "<leader>ji", ":IconPickerNormal<CR>", desc = "Insert Icons" },
    },
  },
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    enabled = true,
    config = { default = true }, -- same as config = true
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = true,
  },
  {
    "sustech-data/wildfire.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },
  {
    "TimUntersberger/neogit",
    cmd = "Neogit",
    config = {
      integrations = { diffview = true },
    },
    keys = {
      { "<leader>gs", "<cmd>Neogit kind=floating<cr>", desc = "Status" },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      modes = {
        search = {
          enabled = false,
        },
      },
    },
  -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "<leader>r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    "monaqa/dial.nvim",
    event = "BufReadPre",
    config = function()
      vim.api.nvim_set_keymap("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
      vim.api.nvim_set_keymap("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
      vim.api.nvim_set_keymap("v", "<C-a>", require("dial.map").inc_visual(), { noremap = true })
      vim.api.nvim_set_keymap("v", "<C-x>", require("dial.map").dec_visual(), { noremap = true })
      vim.api.nvim_set_keymap("v", "g<C-a>", require("dial.map").inc_gvisual(), { noremap = true })
      vim.api.nvim_set_keymap("v", "g<C-x>", require("dial.map").dec_gvisual(), { noremap = true })
    end,
  },
  -- session management
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help" } },
    -- stylua: ignore
    keys = {
      { "<leader>bs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>bl", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>bt", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },
}
