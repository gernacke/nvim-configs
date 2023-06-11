return {
  {
    "NvChad/nvim-colorizer.lua",
    opts = {},
    cmd = { "ColorizerToggle", "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer", "ColorizerReloadAllBuffers" },
    keys = {
      { "<leader>vc", "<cmd>ColorizerToggle<cr>", desc = "Colorizer Toggle" },
    },
  },
  {
    "uga-rosa/ccc.nvim",
    opts = {},
    cmd = { "CccPick", "CccConvert", "CccHighlighterEnable", "CccHighlighterDisable", "CccHighlighterToggle" },
    keys = {
      { "<leader>vp", "<cmd>CccPick<cr>", desc = "Pick Color" },
      { "<leader>vC", "<cmd>CccConvert<cr>", desc = "Convert Color Code" },
    },
  },
}
