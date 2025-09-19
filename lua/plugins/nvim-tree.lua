return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  keys = {
    { "<leader>je", "<CMD>NvimTreeToggle<CR>", desc = "NvimTree" },
    { "<leader>jf", "<CMD>NvimTreeFocus<CR>", desc = "Focus NvimTree" },
  },
  config = function()
    -- local function on_attach(bufnr)
    --   local api = require "nvim-tree.api"
    --
    --   local function opts(desc)
    --     return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    --   end
    --   -- You will need to insert "your code goes here" for any mappings with a custom action_cb
    --   vim.keymap.set("n", "v", api.node.open.vertical, opts "Open: Vertical Split")
    --   vim.keymap.set("n", "l", api.node.open.edit, opts "Open")
    --   vim.keymap.set("n", "<CR>", api.node.open.edit, opts "Open")
    --   vim.keymap.set("n", "o", api.node.open.edit, opts "Open")
    --   vim.keymap.set("n", "h", api.node.navigate.parent_close, opts "Close Directory")
    -- end

    require("nvim-tree").setup({
      -- on_attach = on_attach,
      disable_netrw = false,
      hijack_netrw = true,
      update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = { ".git/" },
      },
      filters = {
        dotfiles = true,
      },
      renderer = {
        root_folder_modifier = ":t",
        icons = {
          glyphs = {
            --     default = "",
            --     symlink = "",
            folder = {
              arrow_open = "",
              arrow_closed = "",
              default = "",
              -- open = "",
              -- empty = "",
              -- empty_open = "",
              -- symlink = "",
              -- symlink_open = "",
            },
            git = {
              unstaged = "",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "❓",
              deleted = "",
              ignored = "◌",
            },
          },
        },
      },
      actions = {
        expand_all = {
          max_folder_discovery = 300,
          exclude = { ".git/" },
        },
        open_file = {
          window_picker = {
            enable = false,
            picker = "default",
            exclude = {
              filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
              buftype = { "nofile", "terminal", "help" },
            },
          },
        },
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        -- icons = {
        --   hint = "",
        --   info = "",
        --   warning = "",
        --   error = "",
        -- },
      },
      view = {
        width = 30,
        preserve_window_proportions = true,
        side = "left",
        float = {
          enable = false,
          quit_on_focus_loss = true,
          open_win_config = {
            relative = "editor",
            border = "rounded",
            width = 30,
            height = 40,
            row = 1,
            col = 1,
          },
        },
      },
    })
  end,
}
