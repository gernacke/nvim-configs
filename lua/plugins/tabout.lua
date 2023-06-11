return {
  "abecodes/tabout.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp",
  },
  config = true,
  -- config = function()
  --   require("tabout").setup {
  --     tabkey = "<C-i>",
  --   }
  -- end,
}
