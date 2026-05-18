return {
  "rmagatti/auto-session",
  -- "cameronr/auto-session",
  -- branch = "fix/file-tree-compatibility",
  lazy = false,

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = { "~/", "~/Downloads", "/" },
    -- auto_save = true, -- Enables/disables auto saving session on exit
    auto_save_enabled = true, -- Enables/disables auto saving session on exit

    -- log_level = 'debug',
    -- pre_restore_cmds = {
    --   function()
    --     require("nvim-tree.api").tree.close()
    --   end,
    -- },
    -- close_filetypes_on_save = { "NvimTree" },
    --
    -- post_restore_cmds = {
    --   function()
    --     require("nvim-tree.api").tree.open()
    --   end,
    -- },
    post_restore_cmds = {
      -- "xxxx", -- You can add other commands here if needed
      function()
        -- Restore nvim-tree after a session is restored
        local nvim_tree_api = require("nvim-tree.api")
        nvim_tree_api.tree.open()
        nvim_tree_api.tree.change_root(vim.fn.getcwd())
        nvim_tree_api.tree.reload()
      end,
    },
  },
}
