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
    pre_save_cmds = {
      function()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "NvimTree" then
            local width = vim.api.nvim_win_get_width(win)
            local path = vim.fn.stdpath("data") .. "/nvim_tree_width"
            vim.fn.writefile({ tostring(width) }, path)
            break
          end
        end
      end,
    },
    post_restore_cmds = {
      function()
        local path = vim.fn.stdpath("data") .. "/nvim_tree_width"
        local lines = vim.fn.filereadable(path) == 1 and vim.fn.readfile(path) or {}
        local target_width = tonumber(lines[1]) or 30

        local nvim_tree_api = require("nvim-tree.api")
        nvim_tree_api.tree.open()
        nvim_tree_api.tree.change_root(vim.fn.getcwd())
        nvim_tree_api.tree.reload()

        vim.schedule(function()
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "NvimTree" then
              pcall(vim.api.nvim_win_set_width, win, target_width)
              break
            end
          end
        end)
      end,
    },
  },
}
