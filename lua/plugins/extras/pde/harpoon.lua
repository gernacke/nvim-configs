return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    -- enabled = false,
    -- stylua: ignore
    keys = {
      { "<leader>h1", function() require("harpoon"):list():add() end, desc = "Add File" },
      { "<leader>hl", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "List File" },
      { "<leader>hf", function() require("harpoon"):list():select(1) end, desc = "Select File 1" },
      { "<leader>hd", function() require("harpoon"):list():select(2) end, desc = "Select File 2" },
      { "<leader>hs", function() require("harpoon"):list():select(3) end, desc = "Select File 3" },
      { "<leader>ha", function() require("harpoon"):list():select(4) end, desc = "Select File 4" },
    },
    -- require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
    -- require("harpoon"):list():select(1)
    config = function()
      local harpoon = require("harpoon")
      harpoon.setup()
      harpoon:extend({
        UI_CREATE = function(cx)
          vim.keymap.set("n", "<C-v>", function()
            harpoon.ui:select_menu_item({ vsplit = true })
          end, { buffer = cx.bufnr })

          vim.keymap.set("n", "<C-x>", function()
            harpoon.ui:select_menu_item({ split = true })
          end, { buffer = cx.bufnr })

          vim.keymap.set("n", "<C-t>", function()
            harpoon.ui:select_menu_item({ tabedit = true })
          end, { buffer = cx.bufnr })
        end,
      })
    end,
  },
}
