return {
  {
    "dhruvasagar/vim-table-mode",
    ft = { "markdown", "org", "norg" },
    keys = {
      { "<leader>tm", desc = "Toggle Table Mode" },
      { "<leader>tt", mode = "v", desc = "Tableize" },
      { "<leader>tdc", desc = "Delete Table Column" },
      { "<leader>tdd", desc = "Delete Table Row" },
      { "<leader>tic", desc = "Insert Column After" },
      { "<leader>tiC", desc = "Insert Column Before" },
    },
  },
}
