--- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Configure lazy.nvim
require("lazy").setup({
  spec = {
    { import = "plugins" },
    { import = "plugins.colorscheme" },
    { import = "plugins.vcs" },
    { import = "plugins.extras.lang" },
    { import = "plugins.extras.ui" },
    { import = "plugins.extras.ai" },
    { import = "plugins.extras.db" },
    { import = "plugins.extras.pde" },
    { import = "plugins.extras.pde.notes" },
  },
  defaults = { lazy = true },
  -- install = { missing = true, colorscheme = { "catppuccin-mocha" } },
  install = { missing = true, colorscheme = { "tokyonight", "gruvbox" } },
  checker = { enabled = true, notify = false },
  concurrency = 30,
  change_detection = {
    notify = false,
  },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
vim.keymap.set("n", "<leader>zz", "<cmd>:Lazy<cr>", { desc = "Plugin Manager" })

-- To make buffeline transparent
-- vim.g.transparent_groups = vim.list_extend(
-- 	vim.g.transparent_groups or {},
-- 	vim.tbl_map(function(v)
-- 		return v.hl_group
-- 	end, vim.tbl_values(require("bufferline.config").highlights))
-- )
