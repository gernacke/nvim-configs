local files_set_cwd = function(path)
  -- Works only if cursor is on the valid file system entry
  local cur_entry_path = MiniFiles.get_fs_entry().path
  local cur_directory = vim.fs.dirname(cur_entry_path)
  vim.fn.chdir(cur_directory)
end

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  callback = function(args)
    vim.keymap.set("n", "gl", files_set_cwd, { buffer = args.data.buf_id })
  end,
})

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
  {
    "echasnovski/mini.files",
    version = "*",
    enabled = false,
    keys = {
      { "<leader>jo", "<cmd>lua MiniFiles.open()<cr>", desc = "Mini Files" },
    },
    config = function()
      require("mini.files").setup({
        mappings = {
          close = "q",
          go_in = "L",
          go_in_plus = "l",
          go_out = "H",
          go_out_plus = "h",
          reset = "<BS>",
          reveal_cwd = "@",
          show_help = "g?",
          synchronize = "=",
          trim_left = "<",
          trim_right = ">",
        },
        windows = {
          -- Whether to show preview of file/directory under cursor
          preview = true,
          -- Width of focused window
          width_focus = 30,
          -- Width of non-focused window
          width_nofocus = 15,
          -- Width of preview window
          width_preview = 45,
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
    -- enabled = false,
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 100,
        search_method = "cover_or_next",
        goto_left = "g[",
        goto_right = "g]",
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        },
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)
      require("which-key").add({
        {
          mode = { "o", "x" },
          { "a ", desc = "Whitespace" },
          { 'a"', desc = 'Balanced "' },
          { "a'", desc = "Balanced '" },
          { "a(", desc = "Balanced (" },
          { "a)", desc = "Balanced )" },
          { "a<", desc = "Balanced <" },
          { "a>", desc = "Balanced >" },
          { "a?", desc = "User Prompt" },
          { "a[", desc = "Balanced [" },
          { "a]", desc = "Balanced ]" },
          { "a_", desc = "Underscore" },
          { "a`", desc = "Balanced `" },
          { "aa", desc = "Argument" },
          { "ab", desc = "Balanced ), ], }" },
          { "ac", desc = "Class" },
          { "af", desc = "Function" },
          { "al", group = "Around Last textobject" },
          { "al ", desc = "Whitespace" },
          { 'al"', desc = 'Balanced "' },
          { "al'", desc = "Balanced '" },
          { "al(", desc = "Balanced (" },
          { "al)", desc = "Balanced )" },
          { "al<", desc = "Balanced <" },
          { "al>", desc = "Balanced >" },
          { "al?", desc = "User Prompt" },
          { "al[", desc = "Balanced [" },
          { "al]", desc = "Balanced ]" },
          { "al_", desc = "Underscore" },
          { "al`", desc = "Balanced `" },
          { "ala", desc = "Argument" },
          { "alb", desc = "Balanced ), ], }" },
          { "alc", desc = "Class" },
          { "alf", desc = "Function" },
          { "alo", desc = "Block, conditional, loop" },
          { "alq", desc = "Quote `, \", '" },
          { "alt", desc = "Tag" },
          { "al{", desc = "Balanced {" },
          { "al}", desc = "Balanced }" },
          { "an", group = "Around Next textobject" },
          { "an ", desc = "Whitespace" },
          { 'an"', desc = 'Balanced "' },
          { "an'", desc = "Balanced '" },
          { "an(", desc = "Balanced (" },
          { "an)", desc = "Balanced )" },
          { "an<", desc = "Balanced <" },
          { "an>", desc = "Balanced >" },
          { "an?", desc = "User Prompt" },
          { "an[", desc = "Balanced [" },
          { "an]", desc = "Balanced ]" },
          { "an_", desc = "Underscore" },
          { "an`", desc = "Balanced `" },
          { "ana", desc = "Argument" },
          { "anb", desc = "Balanced ), ], }" },
          { "anc", desc = "Class" },
          { "anf", desc = "Function" },
          { "ano", desc = "Block, conditional, loop" },
          { "anq", desc = "Quote `, \", '" },
          { "ant", desc = "Tag" },
          { "an{", desc = "Balanced {" },
          { "an}", desc = "Balanced }" },
          { "ao", desc = "Block, conditional, loop" },
          { "aq", desc = "Quote `, \", '" },
          { "at", desc = "Tag" },
          { "a{", desc = "Balanced {" },
          { "a}", desc = "Balanced }" },
          { "i ", desc = "Whitespace" },
          { 'i"', desc = 'Balanced "' },
          { "i'", desc = "Balanced '" },
          { "i(", desc = "Balanced (" },
          { "i)", desc = "Balanced ) including white-space" },
          { "i<", desc = "Balanced <" },
          { "i>", desc = "Balanced > including white-space" },
          { "i?", desc = "User Prompt" },
          { "i[", desc = "Balanced [" },
          { "i]", desc = "Balanced ] including white-space" },
          { "i_", desc = "Underscore" },
          { "i`", desc = "Balanced `" },
          { "ia", desc = "Argument" },
          { "ib", desc = "Balanced ), ], }" },
          { "ic", desc = "Class" },
          { "if", desc = "Function" },
          { "il", group = "Inside Last textobject" },
          { "il ", desc = "Whitespace" },
          { 'il"', desc = 'Balanced "' },
          { "il'", desc = "Balanced '" },
          { "il(", desc = "Balanced (" },
          { "il)", desc = "Balanced ) including white-space" },
          { "il<", desc = "Balanced <" },
          { "il>", desc = "Balanced > including white-space" },
          { "il?", desc = "User Prompt" },
          { "il[", desc = "Balanced [" },
          { "il]", desc = "Balanced ] including white-space" },
          { "il_", desc = "Underscore" },
          { "il`", desc = "Balanced `" },
          { "ila", desc = "Argument" },
          { "ilb", desc = "Balanced ), ], }" },
          { "ilc", desc = "Class" },
          { "ilf", desc = "Function" },
          { "ilo", desc = "Block, conditional, loop" },
          { "ilq", desc = "Quote `, \", '" },
          { "ilt", desc = "Tag" },
          { "il{", desc = "Balanced {" },
          { "il}", desc = "Balanced } including white-space" },
          { "in", group = "Inside Next textobject" },
          { "in ", desc = "Whitespace" },
          { 'in"', desc = 'Balanced "' },
          { "in'", desc = "Balanced '" },
          { "in(", desc = "Balanced (" },
          { "in)", desc = "Balanced ) including white-space" },
          { "in<", desc = "Balanced <" },
          { "in>", desc = "Balanced > including white-space" },
          { "in?", desc = "User Prompt" },
          { "in[", desc = "Balanced [" },
          { "in]", desc = "Balanced ] including white-space" },
          { "in_", desc = "Underscore" },
          { "in`", desc = "Balanced `" },
          { "ina", desc = "Argument" },
          { "inb", desc = "Balanced ), ], }" },
          { "inc", desc = "Class" },
          { "inf", desc = "Function" },
          { "ino", desc = "Block, conditional, loop" },
          { "inq", desc = "Quote `, \", '" },
          { "int", desc = "Tag" },
          { "in{", desc = "Balanced {" },
          { "in}", desc = "Balanced } including white-space" },
          { "io", desc = "Block, conditional, loop" },
          { "iq", desc = "Quote `, \", '" },
          { "it", desc = "Tag" },
          { "i{", desc = "Balanced {" },
          { "i}", desc = "Balanced } including white-space" },
        },
      })
    end,
  },
  {
    "echasnovski/mini.bufremove",
    -- stylua: ignore
    keys = {
      { "<leader>bo", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
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
