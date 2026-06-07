local swap_next, swap_prev = (function()
  local swap_objects = {
    p = "@parameter.inner",
    f = "@function.outer",
    c = "@class.outer",
  }

  local n, p = {}, {}
  for key, obj in pairs(swap_objects) do
    n[string.format("<leader>cx%s", key)] = obj
    p[string.format("<leader>cX%s", key)] = obj
  end

  return n, p
end)()

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    dependencies = {
      -- master = old API (configs.setup), compatible with Neovim 0.11; main = rewrite (0.12+)
      { "nvim-treesitter/nvim-treesitter-textobjects", branch = "master" },
      "JoosepAlviste/nvim-ts-context-commentstring",
      "RRethy/nvim-treesitter-endwise",
    },
    build = ":TSUpdate",
    event = "BufReadPost",
    opts = {
      sync_install = false,
      ensure_installed = {
        "dockerfile",
        "vimdoc",
        "html",
        "lua",
        "markdown",
        "markdown_inline",
        "query",
        "regex",
        "vim",
        "yaml",
        "json",
      },
      highlight = { enable = true },
      indent = { enable = true, disable = { "python" } },
      incremental_selection = { enable = false },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            -- you can optionally set descriptions to the mappings (used in the desc parameter of nvim_buf_set_keymap
            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            ["i="] = "@assignment.lhs",
            ["i-"] = "@assignment.rhs",
            ["i_"] = "@assignment.outer",
            ["a;"] = "@comment.outer",
            -- ["io"] = "@conditional.inner",
            -- ["ao"] = "@conditional.outer",
            -- ["il"] = "@loop.inner",
            -- ["al"] = "@loop.outer",
            ["iN"] = "@number.inner",
          },
          selection_modes = {
            ["@parameter.outer"] = "v", -- charwise
            ["@class.outer"] = "v", -- charwise
            ["@function.outer"] = "V", -- linewise
          },
        },
        swap = {
          enable = true,
          swap_next = swap_next,
          swap_previous = swap_prev,
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
          goto_next = {
            ["]l"] = "@loop.*",
            ["]o"] = "@conditional.inner",
          },
          goto_previous = {
            ["[l"] = "@loop.*",
            ["[o"] = "@conditional.inner",
          },
        },
      },
      enable = true,
      matchup = {
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
        },
        -- treesitter integration calls _node_id on a nil node with the master
        -- branch on Neovim 0.11, crashing on CursorMoved. Use the regexp engine.
        enable = false,
      },
      endwise = {
        enable = true,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.powershell = {
        install_info = {
          url = "~/repositories/tree-sitter-PowerShell",
          files = { "src/parser.c" },
          branch = "main",
          generate_requires_npm = false,
          requires_generate_from_grammar = false,
        },
        filetype = "ps1",
      }
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local npairs = require("nvim-autopairs")
      npairs.setup({
        check_ts = true,
        fast_wrap = {
          chars = { "{", "[", "(", '"', "'", "`" },
          pattern = [=[[%'%"%>%]%)%}%,]]=],
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          highlight = "Search",
          highlight_grey = "Comment",
        },
      })
    end,
  },
}
