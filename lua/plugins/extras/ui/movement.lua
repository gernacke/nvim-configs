return {
  -- {
  --   "declancm/cinnamon.nvim",
  --   lazy = false,
  --   config = function()
  --     require("cinnamon").setup({ extra_keymaps = true, max_length = 70, scroll_limit = 100 })
  --   end,
  -- },
  {
    "karb94/neoscroll.nvim",
    lazy = false,
    config = function()
      require("neoscroll").setup({
        easing_function = "quadratic",
        respect_scrolloff = true, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
      })
      local t = {}
      -- Syntax: t[keys] = {function, {function arguments}}
      -- Use the "sine" easing function
      t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "120", [['circular']] } }
      t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "120", [['circular']] } }
      -- Use the "circular" easing function
      t["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "100", [['circular']] } }
      t["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "100", [['circular']] } }
      -- Pass "nil" to disable the easing animation (constant scrolling speed)
      t["<C-y>"] = { "scroll", { "-0.10", "false", "50", nil } }
      t["<C-e>"] = { "scroll", { "0.10", "false", "50", nil } }
      -- When no easing function is provided the default easing function (in this case "quadratic") will be used
      t["zt"] = { "zt", { "100" } }
      t["zz"] = { "zz", { "100" } }
      t["zb"] = { "zb", { "100" } }

      require("neoscroll.config").set_mappings(t)
    end,
  },
}
