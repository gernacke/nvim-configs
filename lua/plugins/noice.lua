local M = {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
  },
}

function M.config()
  require("noice").setup({
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = true,
      lsp_doc_border = true,
      cmdline_output_to_split = false,
    },
    messages = {
      -- If you enable messages, then the cmdline is enabled automatically.
      -- This is a current Neovim limitation.
      enabled = false, -- enables the Noice messages UI
    },
    views = {
      cmdline_popup = {
        position = {
          row = "50%",
          col = "50%",
        },
      },
    },
  })
end

return M
