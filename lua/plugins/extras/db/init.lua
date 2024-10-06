return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "sql" })
    end,
  },
  {
    "tpope/vim-dadbod",
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
      "tpope/vim-dotenv",
    },
    opts = {
      db_competion = function()
        require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
      end,
    },
    config = function(_, opts)
      vim.g.db_ui_save_location = "~/Google Drive/My Drive/VScode/SQL-Queries"
        .. require("plenary.path").path.sep
        .. "DBUI"
      vim.g.db_ui_execute_on_save = 0
      vim.g.db_ui_show_database_icon = 1
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_icons = {
        expanded = {
          db = "▾  ",
          buffers = "▾ 󰕲 ",
          saved_queries = "▾ 󰷏 ",
          schemas = "▾  ",
          schema = "▾  ",
          tables = "▾  ",
          table = "▾  ",
        },
        collapsed = {
          db = "▸ ",
          buffers = "▸ 󰕲",
          saved_queries = "▸ 󰉖",
          schemas = "▸ ",
          schema = "▸ ",
          tables = "▸ ",
          table = "▸ ",
        },
        saved_query = "󰸩",
        new_query = "",
        tables = "",
        buffers = "",
        add_connection = "󰆺",
        connection_ok = "✓",
        connection_error = "✕",
      }
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "sql",
        },
        command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "sql",
          "mysql",
          "plsql",
        },
        callback = function()
          vim.schedule(opts.db_completion)
        end,
      })
    end,
    keys = {
      { "<leader>et", "<cmd>DBUIToggle<cr>", desc = "Toggle UI" },
      { "<leader>el", "<Plug>(DBUI_ExecuteQuery)", desc = "Execute" },
      { "<leader>el", "<Plug>(DBUI_ExecuteQuery)", mode = "v", desc = "Execute" },
      { "<leader>ef", "<cmd>DBUIFindBuffer<cr>", desc = "Find Query Buffer" },
      { "<leader>er", "<cmd>DBUIRenameBuffer<cr>", desc = "Rename Query Buffer" },
      { "<leader>eq", "<cmd>DBUILastQueryInfo<cr>", desc = "Last Query Info" },
    },
  },
}
