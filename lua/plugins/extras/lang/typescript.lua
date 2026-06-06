return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "javascript", "typescript", "tsx" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ts_ls = {},
      },
      setup = {
        ts_ls = function(_, opts)
          local lsp_utils = require("plugins.lsp.utils")
          lsp_utils.on_attach(function(client, buffer)
            if client.name == "ts_ls" then
              vim.keymap.set("n", "<leader>co", function()
                vim.lsp.buf.execute_command({ command = "_typescript.organizeImports", arguments = { vim.api.nvim_buf_get_name(0) } })
              end, { buffer = buffer, desc = "Organize Imports" })
            end
          end)
        end,
      },
    },
  },
}
