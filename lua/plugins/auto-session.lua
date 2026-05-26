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
      function()
        local saved_widths = {}
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local ft = vim.bo[vim.api.nvim_win_get_buf(win)].filetype
          if ft ~= "NvimTree" then
            saved_widths[win] = vim.api.nvim_win_get_width(win)
          end
        end

        local nvim_tree_api = require("nvim-tree.api")
        nvim_tree_api.tree.open()
        nvim_tree_api.tree.change_root(vim.fn.getcwd())
        nvim_tree_api.tree.reload()

        vim.schedule(function()
          for win, width in pairs(saved_widths) do
            if vim.api.nvim_win_is_valid(win) then
              pcall(vim.api.nvim_win_set_width, win, width)
            end
          end
        end)
      end,
    },
  },
}
