require("config.options")
require("config.usercommands")
require("config.lazy")
require("config.autocmds")

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("config.keymaps")
    require("config.highlightgroup")
  end,
})
