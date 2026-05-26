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
        local ok, api = pcall(require, "nvim-tree.api")
        if not ok then
          return
        end
        local state_path = vim.fn.stdpath("data") .. "/nvim_tree_state"
        if api.tree.is_visible() then
          local width = 30
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "NvimTree" then
              width = vim.api.nvim_win_get_width(win)
              break
            end
          end
          vim.fn.writefile({ "open", tostring(width) }, state_path)
          api.tree.close()
        else
          vim.fn.writefile({ "closed" }, state_path)
        end
      end,
    },
    post_restore_cmds = {
      function()
        local state_path = vim.fn.stdpath("data") .. "/nvim_tree_state"
        if vim.fn.filereadable(state_path) == 0 then
          return
        end
        local lines = vim.fn.readfile(state_path)
        if lines[1] ~= "open" then
          return
        end
        local target_width = tonumber(lines[2]) or 30

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
