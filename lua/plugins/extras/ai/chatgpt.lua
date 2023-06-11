return {
  "jackMort/ChatGPT.nvim",
  cmd = { "ChatGPT", "ChatGPTRun", "ChatGPTActAs", "ChatGPTCompleteCode", "ChatGPTEditWithInstructions" },
  enabled = true,
  opts = {
    api_key_cmd = "gpg --decrypt ~/repositories/all-dotfiles/chatgpt/api-key.gpg 2>/dev/null",
    popup_layout = {
      default = "center",
      center = {
        width = "65%",
        height = "80%",
      },
      right = {
        width = "30%",
        width_settings_open = "50%",
      },
    },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function(_, opts)
    require("chatgpt").setup(opts)
  end,
}
