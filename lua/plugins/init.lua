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
      picker = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = false },
      scroll = { enabled = true },
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
    keys = {
      -- Top Pickers & Explorer
      {
        "<leader><space>",
        function()
          Snacks.picker.smart()
        end,
        desc = "Smart Find Files",
      },
      {
        "<leader><tab>",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Buffers",
      },
      {
        "<leader>/",
        function()
          Snacks.picker.grep()
        end,
        desc = "Grep",
      },
      {
        "<leader>:",
        function()
          Snacks.picker.command_history()
        end,
        desc = "Command History",
      },
      {
        "<leader>n",
        function()
          Snacks.picker.notifications()
        end,
        desc = "Notification History",
      },
      {
        "<leader>fe",
        function()
          Snacks.explorer()
        end,
        desc = "File Explorer",
      },
      -- find
      {
        "<leader>ff",
        function()
          Snacks.picker.files()
        end,
        desc = "Find Files",
      },
      {
        "<leader>fg",
        function()
          Snacks.picker.git_files()
        end,
        desc = "Find Git Files",
      },
      {
        "<leader>fl",
        function()
          Snacks.picker.recent()
        end,
        desc = "Recent",
      },
      -- Grep
      {
        "<leader>sb",
        function()
          Snacks.picker.lines()
        end,
        desc = "Buffer Lines",
      },
      {
        "<leader>sB",
        function()
          Snacks.picker.grep_buffers()
        end,
        desc = "Grep Open Buffers",
      },
      {
        "<leader>sw",
        function()
          Snacks.picker.grep_word()
        end,
        desc = "Visual selection or word",
        mode = { "n", "x" },
      },
      -- Zen mode
      {
        "<leader>vn",
        function()
          Snacks.zen()
        end,
        desc = "Toggle Zen Mode",
      },
      {
        "<leader>.",
        function()
          Snacks.scratch()
        end,
        desc = "Toggle Scratch Buffer",
      },
      {
        "<leader>bo",
        function()
          Snacks.bufdelete()
        end,
        desc = "Delete Buffer",
      },
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
    "chrisgrieser/nvim-spider", -- plugin to enhance default word jumping
    lazy = true,
    keys = {
      { "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
      { "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
      { "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
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
