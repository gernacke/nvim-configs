return {
  -- {
  --   "catppuccin/nvim",
  --   lazy = false,
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
  "jose-elias-alvarez/null-ls.nvim",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "godlygeek/tabular",
  "nvim-lua/popup.nvim",
  "ckipp01/stylua-nvim",
  "moll/vim-bbye",
  "neovim/nvim-lspconfig",
  "mortepau/codicons.nvim",
  "junegunn/vim-easy-align",
  "preservim/vim-markdown",
  {
    "folke/zen-mode.nvim",
    config = true,
    cmd = { "ZenMode" },
  },
  { "tpope/vim-repeat", event = "VeryLazy" },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("gruvbox").setup()
      --            vim.cmd [[colorscheme gruvbox]]
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    dependencies = { "DaikyXendo/nvim-material-icon" },
    config = function()
      require("nvim-web-devicons").setup {
        override = require("nvim-material-icon").get_icons(),
      }
    end,
  },
  {
    "andymass/vim-matchup",
    event = { "BufReadPost" },
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
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
      require("trouble").setup {}
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
    event = "BufReadPre",
    config = true,
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = true,
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
    "ggandor/leap.nvim",
    event = "VimEnter",
    config = function()
      local keymap = vim.keymap

      require("leap").set_default_keymaps()

      keymap.set({ "n", "x", "o" }, "f", "<Plug>(leap-forward-to)")
      keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-backward-to)")
    end,
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
