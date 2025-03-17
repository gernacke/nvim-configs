return {
  "akinsho/toggleterm.nvim",
  keys = { [[<C-\>]] },
  cmd = { "ToggleTerm", "TermExec" },
  config = function(opts)
    function set_terminal_keymaps()
      local opts = { noremap = true }
      vim.api.nvim_buf_set_keymap(0, "t", "<Esc>", [[<C-\><C-n>]], opts)
    end
    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

    require("toggleterm").setup({
      size = 30,
      hide_numbers = true,
      open_mapping = [[<C-\>]],
      shade_filetypes = {},
      shade_terminals = false,
      shading_factor = 0.3,
      start_in_insert = true,
      persist_size = true,
      direction = "horizontal",
      winbar = {
        enabled = false,
        name_formatter = function(term)
          return term.name
        end,
      },
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    })
  end,
}
