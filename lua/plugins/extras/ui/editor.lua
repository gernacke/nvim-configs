return {
  {
    "xiyaowong/nvim-transparent",
    cmd = { "TransparentEnable", "TransparentDisable", "TransparentToggle" },
    opts = {
      -- enable = true, -- boolean: enable transparent
      extra_groups = { -- table/string: additional groups that should be cleared
        -- In particular, when you set it to 'all', that means all available groups

        -- example of akinsho/nvim-bufferline.lua
        -- "BufferLineTabClose",
        -- "BufferLineTab",
        -- "BufferlineBufferSelected",
        -- "BufferLineFill",
        -- "BufferLineBackground",
        -- "BufferLineSeparator",
        -- "BufferLineIndicatorSelected",
        "all",
        "TelescopeBorder",
        "BufferLineDevIconLuaInactive",
        "BufferLineDevIconLuaSelected",
        "BufferLineDevIconLua",
      },
      exclude_groups = {}, -- table: groups you don't want to clear
    },
    config = function(_, opts)
      require("transparent").setup(opts)
    end,
    keys = {
      { "<leader>vt", "<CMD>TransparentToggle<CR>", desc = "Transparent Toggle" },
    },
  },
}
