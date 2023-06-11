return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",

    config = function()
      local components = require "plugins.statusline.components"
      local hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end
      local diagnostics = {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        sections = { "error", "warn" },
        symbols = { error = " ", warn = " " },
        colored = false,
        update_in_insert = false,
        always_visible = false,
      }
      local branch = {
        "branch",
        icons_enabled = true,
        icon = "",
      }
      local mode = {
        "mode",
        fmt = function(str)
          return "-- " .. str .. " --"
        end,
      }
      local diff = {
        "diff",
        colored = false,
        symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
        cond = hide_in_width,
      }
      require("lualine").setup {
        options = {
          icons_enabled = true,
          theme = "auto",
          component_separators = {},
          section_separators = {},
          disabled_filetypes = {
            statusline = { "alpha", "lazy", "Outline" },
            winbar = {
              "help",
              "alpha",
              "lazy",
            },
          },
          always_divide_middle = true,
          globalstatus = true,
        },
        sections = {
          lualine_a = { branch, diagnostics },
          lualine_b = { mode },
          lualine_c = { diff, components.separator, components.lsp_client },
          lualine_x = {
            "filename",
            components.spaces,
            "encoding",
            "fileformat",
            "filetype",
            "progress",
            -- Lazyvim package updates notification integration
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = { fg = "ff9e64" },
            },
          },
          lualine_y = {},
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        extensions = { "nvim-tree", "toggleterm", "quickfix" },
      }
    end,
  },
}
