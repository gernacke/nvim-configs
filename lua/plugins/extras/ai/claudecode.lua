return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {
      terminal = {
        split_side = "right",
        split_width_percentage = 0.40,
        provider = "snacks",
        auto_close = true,
      },
    },
    config = true,
    keys = {
      { "<leader>aT", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude Code" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude Model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add Buffer to Claude" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send Selection to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add File to Claude",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      { "<leader>aA", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Claude Diff" },
      { "<leader>aD", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny Claude Diff" },
    },
  },
}
