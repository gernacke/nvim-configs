return {
  {
    "utilyre/barbecue.nvim",
    event = "VeryLazy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    enabled = false,
    config = true,
  },
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    keys = {
      { "<leader>fo", "<cmd>Lspsaga outline<cr>", desc = "Symbol Outline" },
    },
    config = function()
      require("lspsaga").setup({
        -- ui = {
        --   kind = {
        --     ["Function"] = { " ", "Function" },
        --     ["Enum"] = { "", "@number" },
        --     ["Object"] = { " ", "Type" },
        --     ["Array"] = { " ", "Type" },
        --     ["Constant"] = { " ", "Constant" },
        --     ["Namespace"] = { " ", "Include" },
        --     ["Package"] = { " ", "Label" },
        --     ["Class"] = { " ", "Include" },
        --     ["Method"] = { "m ", "Function" },
        --     ["Property"] = { " ", "@property" },
        --     ["Field"] = { " ", "@field" },
        --     ["Interface"] = { "練 ", "Type" },
        --     ["Variable"] = { " ", "@Variable" },
        --     ["String"] = { " ", "String" },
        --     ["Number"] = { " ", "Number" },
        --     ["Boolean"] = { "◩ ", "Boolean" },
        --     ["Key"] = { " ", "Constant" },
        --     ["Null"] = { "ﳠ ", "Constant" },
        --     ["EnumMember"] = { "", "Number" },
        --     ["Struct"] = { " ", "Type" },
        --     ["Event"] = { " ", "Constant" },
        --     ["Operator"] = { " ", "Operator" },
        --     ["TypeParameter"] = { "", "Type" },
        --   },
        -- },

        -- The highlight animation when jumped to a definition
        -- beacon = {
          -- enable = true,
          -- frequency = 20,
        -- },
        symbol_in_winbar = {
          enable = true,
          separator = " ",
          -- ignore_patterns = {},
          hide_keyword = true,
          show_file = true,
          folder_level = 2,
          -- respect_root = false,
          -- color_mode = false,
        },
        finder = {
          left_width = 0.14,
          keys = {
            vsplit = "v",
            split = "x",
          },
        },
        outline = {
          layout = 'float',
        },
      })
    end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
}
