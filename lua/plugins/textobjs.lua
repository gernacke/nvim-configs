return {
  {
    "chrisgrieser/nvim-various-textobjs",
    config = function()
      require("various-textobjs").setup { useDefaultKeymaps = true }
    end,
    event = "VeryLazy",
    enabled = true,
  },
  { "axieax/urlview.nvim", enabled = false, cmd = { "UrlView" } },
}
