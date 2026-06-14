local M = {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
  },
}

function M.config()
  -- noice.text.treesitter.highlight crashes on unknown TS languages (e.g. "text" in Rust LSP
  -- docs). has_lang() returns true in 0.11 because language.add() no longer throws, but
  -- LanguageTree.new() then asserts. Wrap highlight in pcall so unknown langs silently skip TS.
  local ts = require("noice.text.treesitter")
  local orig_ts_highlight = ts.highlight
  ts.highlight = function(...)
    pcall(orig_ts_highlight, ...)
  end

  require("noice").setup({
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      signature = {
        view = "lsp_signature_help",
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
      -- Pad hover docs (K) so content isn't flush against the border.
      hover = {
        border = {
          padding = { 1, 2 },
        },
      },
      -- Signature help: flush directly above cursor, no top/bottom padding.
      lsp_signature_help = {
        view = "hover",
        border = {
          padding = { 0, 1 },
        },
        position = { row = 0, col = 0 },
        relative = "cursor",
        anchor = "SW",
      },
    },
  })
end

return M
