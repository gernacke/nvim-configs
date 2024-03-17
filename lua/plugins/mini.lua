-- Create a function and keymappings to delete surrounding indentation
vim.keymap.set("n", "dsi", function()
  -- select inner indentation
  require("various-textobjs").indentation(true, true)

  -- plugin only switches to visual mode when textobj found
  local notOnIndentedLine = vim.fn.mode():find("V") == nil
  if notOnIndentedLine then
    return
  end

  -- dedent indentation
  vim.cmd.normal({ ">", bang = true })

  -- delete surrounding lines
  local endBorderLn = vim.api.nvim_buf_get_mark(0, ">")[1] + 1
  local startBorderLn = vim.api.nvim_buf_get_mark(0, "<")[1] - 1
  vim.cmd(tostring(endBorderLn) .. " delete") -- delete end first so line index is not shifted
  vim.cmd(tostring(startBorderLn) .. " delete")
end, { desc = "Delete surrounding indentation" })

return {
  {
    "echasnovski/mini.map",
    keys = {
      --stylua: ignore
      { "<leader>vm", function() require("mini.map").toggle {} end, desc = "Toggle Minimap", },
    },
    config = function()
      local map = require("mini.map")
      require("mini.map").setup({
        symbols = {
          -- Encode symbols. See `:h MiniMap.config` for specification and
          -- `:h MiniMap.gen_encode_symbols` for pre-built ones.
          -- Default: solid blocks with 3x2 resolution.
          encode = map.gen_encode_symbols.dot("4x2"),

          -- Scrollbar parts for view and line. Use empty string to disable any.
          scroll_line = "▶",
          scroll_view = "┃",
        },
      })
    end,
  },
  -- {
  --   "echasnovski/mini.jump",
  --   opts = {},
  --   keys = { "f", "F", "t", "T" },
  --   config = function(_, opts)
  --     require("mini.jump").setup(opts)
  --   end,
  -- },
  {
    "echasnovski/mini.move",
    version = "*",
    keys = { "<A-h>", "<A-l>", "<A-j>", "<A-k>" },
  },
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        search_method = "cover_or_nearest",
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
          -- Whole buffer
          g = function()
            local from = { line = 1, col = 1 }
            local to = {
              line = vim.fn.line("$"),
              col = math.max(vim.fn.getline("$"):len(), 1),
            }
            return { from = from, to = to }
          end,
        },
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)
      ---@type table<string, string|table>
      if require("utils").has("which-key.nvim") then
        local i = {
          [" "] = "Whitespace",
          ['"'] = 'Balanced "',
          ["'"] = "Balanced '",
          ["`"] = "Balanced `",
          ["("] = "Balanced (",
          [")"] = "Balanced ) including white-space",
          [">"] = "Balanced > including white-space",
          ["<lt>"] = "Balanced <",
          ["]"] = "Balanced ] including white-space",
          ["["] = "Balanced [",
          ["}"] = "Balanced } including white-space",
          ["{"] = "Balanced {",
          ["?"] = "User Prompt",
          _ = "Underscore",
          a = "Argument",
          b = "Balanced ), ], }",
          c = "Class",
          f = "Function",
          o = "Block, conditional, loop",
          q = "Quote `, \", '",
          t = "Tag",
        }
        local a = vim.deepcopy(i)
        for k, v in pairs(a) do
          a[k] = v:gsub(" including.*", "")
        end

        local ic = vim.deepcopy(i)
        local ac = vim.deepcopy(a)
        for key, name in pairs({ n = "Next", l = "Last" }) do
          i[key] = vim.tbl_extend("force", { name = "Inside " .. name .. " textobject" }, ic)
          a[key] = vim.tbl_extend("force", { name = "Around " .. name .. " textobject" }, ac)
        end
        require("which-key").register({
          mode = { "o", "x" },
          i = i,
          a = a,
        })
      end
    end,
  },
  {
    "echasnovski/mini.bufremove",
    -- stylua: ignore
    keys = {
      { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
  },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      options = {
        custom_commentstring = function()
          return vim.bo.commentstring
        end,
      },
      mappings = {
        comment = "gc",
        comment_line = "gcc",
        comment_visual = "gc",
        textobject = "gc",
      },
      hooks = {
        pre = function()
          require("ts_context_commentstring.internal").update_commentstring({})
        end,
      },
    },
    config = function(_, opts)
      require("mini.comment").setup(opts)
    end,
  },
  {
    "echasnovski/mini.misc",
    config = true,
    --stylua: ignore
    keys = {
      { "<leader>vz", function() require("mini.misc").zoom() end, desc = "Toggle Zoom" },
    },
  },
  {
    "echasnovski/mini.bracketed",
    event = "VeryLazy",
    config = function()
      require("mini.bracketed").setup()
    end,
  },
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    config = function(_, opts)
      require("mini.pairs").setup(opts)
    end,
  },
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    enabled = false,
    config = function()
      require("mini.animate").setup({})
    end,
  },
}
