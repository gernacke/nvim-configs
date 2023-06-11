return {
  {
    "folke/styler.nvim",
    event = "VeryLazy",
    config = function()
      require("styler").setup {
        themes = {
          -- markdown = { colorscheme = "gruvbox" },
          -- help = { colorscheme = "tokyonight-night" },
        },
      }
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    -- priority = 1000,
    config = function()
      require("gruvbox").setup {
        contrast = "hard",
      }
      -- vim.cmd [[colorscheme gruvbox]]
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    -- priority = 1000,
    opts = {
      style = "Moon",
      transparent = false,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
    -- enabled = false,
    config = function(_, opts)
      local tokyonight = require "tokyonight"
      tokyonight.setup(opts)
      -- tokyonight.load()
      -- vim.cmd [[colorscheme tokyonight-moon]]
    end,
  },
  -- { "catppuccin/nvim", lazy = false, enabled = true, name = "catppuccin" },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      background = {
        dark = "wave",
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          FloatTitle = { bg = "none" },

          -- Save an hlgroup with dark background and dimmed foreground
          -- so that you can use it where your still want darker windows.
          -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

          -- Popular plugins that open floats will link to NormalFloat by default;
          -- set their background accordingly if you wish to keep them dark and borderless
          LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        }
      end,
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
      -- transparent = true,
    },
    name = "kanagawa",
    config = function(_, opts)
      local kanagawa = require "kanagawa"
      require("kanagawa").setup(opts)
      kanagawa.load()
    end,
  },
}
