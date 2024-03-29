return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = false,
          auto_trigger = false,
        },
        panel = { enabled = false },
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = "copilot.lua",
    event = { "InsertEnter", "LspAttach" },
    config = function()
      require("copilot_cmp").setup({
        fix_pairs = true,
      })
    end,
  },
}
