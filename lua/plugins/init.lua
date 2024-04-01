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
    "folke/zen-mode.nvim",
    opts = {
      window = {
        backdrop = 0.9,
      },
      plugins = {
        lualine = { enabled = false },
      },
    },
    -- config = function ()
    --   require("zen-mode").setup(options)
    -- end,
    cmd = { "ZenMode" },
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
    cmd = "TroubleToggle",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup({})
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
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = true,
    event = "BufReadPre",
    config = function()
      require("ibl").setup({
        indent = { char = "▏" },
        scope = {
          -- Shows an underline on the first line of the scope
          show_start = false,
        },
      })
    end,
  },
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
    opts = {},
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
  },
  -- {
  --   "unblevable/quick-scope",
  --   -- lazy = false,
  --   config = function()
  --     vim.cmd([[
  --        let g:qs_max_chars = 160
  --        let g:qs_buftype_blacklist = ['NvimTree', 'nofile']
  --        let g:qs_enable = 0
  --        " let g:qs_buftype_blacklist = ['terminal', 'nofile']
  --        ]])
  --   end,
  --   keys = {
  --     { "<leader>a", "<plug>(QuickScopeToggle)", mode = { "x", "n" }, desc = "Quick Scope" },
  --   },
  -- },
  -- {
  --   "ggandor/leap.nvim",
  --   event = "VimEnter",
  --   config = function()
  --     local keymap = vim.keymap
  --
  --     require("leap").set_default_keymaps()
  --
  --     keymap.set({ "n", "x", "o" }, "<leader>/", "<Plug>(leap-forward-to)")
  --     keymap.set({ "n", "x", "o" }, "<leader>?", "<Plug>(leap-backward-to)")
  --   end,
  -- },
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
