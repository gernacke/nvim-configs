return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "sql" })
    end,
  },
  {
    "tpope/vim-dadbod",
    cmd = { "DB", "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
      "tpope/vim-dotenv",
    },
    opts = {
      db_completion = function()
        require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
      end,
    },
    config = function(_, opts)
      vim.g.db_ui_save_location = "~/Google Drive/My Drive/VScode/SQL-Queries"
        .. require("plenary.path").path.sep
        .. "DBUI"

      -- sidebar
      vim.g.db_ui_win_position = "left"
      vim.g.db_ui_winwidth = 35
      vim.g.db_ui_show_help = 0

      -- behaviour
      vim.g.db_ui_execute_on_save = 0
      vim.g.db_ui_auto_execute_table_helpers = 1

      -- appearance
      vim.g.db_ui_show_database_icon = 1
      vim.g.db_ui_use_nerd_fonts = 1

      -- SQL Server–specific table helpers (default helpers assume MySQL LIMIT syntax)
      vim.g.db_ui_table_helpers = {
        ["sqlserver"] = {
          ["List"] = "SELECT TOP 200 * FROM {optional_schema}{table}",
          ["Count"] = "SELECT COUNT(*) FROM {optional_schema}{table}",
          ["Columns"] = "SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE"
            .. " FROM INFORMATION_SCHEMA.COLUMNS"
            .. " WHERE TABLE_NAME = '{table}'"
            .. " ORDER BY ORDINAL_POSITION",
          ["Primary Keys"] = "SELECT COLUMN_NAME"
            .. " FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE"
            .. " WHERE TABLE_NAME = '{table}'"
            .. " AND CONSTRAINT_NAME LIKE 'PK_%'",
          ["Foreign Keys"] = "SELECT fk.name FK, tp.name Parent, cp.name ParentCol,"
            .. " tr.name RefTable, cr.name RefCol"
            .. " FROM sys.foreign_keys fk"
            .. " JOIN sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id"
            .. " JOIN sys.tables tp ON fkc.parent_object_id = tp.object_id"
            .. " JOIN sys.columns cp ON fkc.parent_object_id = cp.object_id AND fkc.parent_column_id = cp.column_id"
            .. " JOIN sys.tables tr ON fkc.referenced_object_id = tr.object_id"
            .. " JOIN sys.columns cr ON fkc.referenced_object_id = cr.object_id AND fkc.referenced_column_id = cr.column_id"
            .. " WHERE tp.name = '{table}'",
          ["Indexes"] = "EXEC sp_helpindex '{optional_schema}{table}'",
        },
      }

      vim.g.db_ui_icons = {
        expanded = {
          db = "▾  ",
          buffers = "▾ 󰕲 ",
          saved_queries = "▾ 󰷏 ",
          schemas = "▾  ",
          schema = "▾  ",
          tables = "▾  ",
          table = "▾  ",
        },
        collapsed = {
          db = "▸ ",
          buffers = "▸ 󰕲",
          saved_queries = "▸ 󰉖",
          schemas = "▸ ",
          schema = "▸ ",
          tables = "▸ ",
          table = "▸ ",
        },
        saved_query = "󰸩",
        new_query = "",
        tables = "",
        buffers = "",
        add_connection = "󰆺",
        connection_ok = "✓",
        connection_error = "✕",
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "sql", "mysql", "plsql" },
        callback = function()
          vim.opt_local.omnifunc = "vim_dadbod_completion#omni"
          vim.opt_local.foldmethod = "indent"
          vim.opt_local.colorcolumn = "120"
          vim.opt_local.wrap = false
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
