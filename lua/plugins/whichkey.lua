return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.setup({
      show_help = false,
      plugins = { spelling = true }, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      key_labels = { ["<leader>"] = "SPC" },
      triggers = "auto",
    })
    wk.register({
      a = { name = "+AI", p = { "<CMD>Copilot panel<CR>", "Copilot panel" } },
      b = { name = "+Buffers" },
      c = {
        name = "+Code",
        x = {
          name = "Swap Next",
          f = "Function",
          p = "Parameter",
          c = "Class",
        },
        X = {
          name = "Swap Previous",
          f = "Function",
          p = "Parameter",
          c = "Class",
        },
        h = { "<CMD>lua require('config.autocmds').toggle_crosshairs()<CR>", "No Highlight" },
        c = { "<CMD>lua require('config.autocmds').toggle_color_column()<CR>", "Toggle Color Column" },
        w = { "<CMD>lua require('config.autocmds').toggle_text_wrap()<CR>", "Toggle Text Wrap" },
      },
      d = { name = "+Debug" },
      e = { name = "+Database" },
      f = { name = "+File" },
      g = {
        name = "+Git",
        h = {
          name = "+Hunk",
        },
        d = { name = "+Diffview" },
        g = { "<CMD>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
      },
      j = {
        name = "+Editing",
        h = {
          { "<CMD>e ~/repositories/workbench/help.md<CR>", "help notes" },
        },
        a = {
          { "<CMD>e ~/repositories/workbench/l1.md<CR>", "list 1" },
        },
        s = {
          { "<CMD>e ~/repositories/workbench/l2.md<CR>", "list 2" },
        },
        d = {
          { "<CMD>e ~/repositories/workbench/l3.md<CR>", "list 3" },
        },
      },
      l = {
        name = "+LSP",
        -- D = {
        --   { "<cmd>lua require('config.autocmds').DiagnosticToggle<cr>", "Toggle Diagnostic" }
        -- },
      },
      P = { name = "List Projects" },
      q = {
        name = "Quit",
        q = {
          function()
            require("utils").quit()
          end,
          "Quit",
        },
        t = {
          "<cmd>tabclose<cr>",
          "Close Tab",
        },
      },
      s = {
        name = "+Search",
        c = {
          function()
            require("utils.coding").cht()
          end,
          "Cheatsheets",
        },
        d = {
          "<CMD>lua require('utils.telescope').search_all_dotfiles()<CR>",
          "Find Dot Files",
        },
        D = {
          "<CMD>lua require('utils.telescope').grep_all_dotfiles()<CR>",
          "Grep Dot Files",
        },
        f = {
          "<CMD>lua require('utils.telescope').search_nvim_configs()<CR>",
          "Find Nvim Configs",
        },
        F = {
          "<CMD>lua require('utils.telescope').grep_nvim_configs()<CR>",
          "Grep Nvim Configs",
        },
        n = { "<CMD>lua require('utils.telescope').search_notefiles()<CR>", "Find Notes" },
        N = { "<CMD>lua require('utils.telescope').grep_notes()<CR>", "Grep Notes" },
        o = {
          function()
            require("utils.coding").stack_overflow()
          end,
          "Stack Overflow",
        },
        q = {
          "<CMD>lua require('utils.telescope').search_sqlfiles()<CR>",
          "Find SQL Scripts",
        },
        Q = {
          "<CMD>lua require('utils.telescope').grep_sqlfiles()<CR>",
          "Grep SQL Scripts",
        },
        r = {
          function()
            require("utils.coding").reddit()
          end,
          "Reddit",
        },
      },
      t = {
        name = "+Test/Table",
        d = { name = "Table Delete" },
        i = { name = "Table Insert" },
      },
      v = {
        name = "+Virtual",
        n = { "<cmd>ZenMode<CR>", "ZenMode" },
      },
      w = { "<cmd>update!<CR>", "Save" },
      z = { name = "+ZK" },
    }, { prefix = "<leader>", mode = { "n", "v" } })
  end,
}
