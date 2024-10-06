return {
  {
    "jakewvincent/mkdnflow.nvim",
    ft = { "markdown" },
    rocks = "luautf8",
    opts = {},
    enabled = false,
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup({
        app = "browser",
        filetype = { "md", "markdown" },
      })
      -- refer to `configuration to change defaults`
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },
  { "mzlogin/vim-markdown-toc", ft = { "markdown" } },
  -- {
  --   "mickael-menu/zk-nvim",
  --   lazy = false,
  --   config = function()
  --     require("zk").setup {
  --       picker = "telescope",
  --       lsp = {
  --         config = {
  --           cmd = { "zk", "lsp" },
  --           name = "zk",
  --         },
  --         auto_attach = {
  --           enabled = true,
  --           filetypes = { "markdown" },
  --         },
  --       },
  --     }
  --   end,
  --   keys = {
  --     { "<leader>zl", "<CMD>ZkInsertLink<CR>", desc = "Current Note Links" },
  --     { "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", desc = "New ZK Note" },
  --     { "<leader>zf", "<CMD>ZkNotes { sort = { 'modified' } }<CR>", desc = "Search ZK Notes" },
  --     { "<leader>z/", "<CMD>lua require('utils.telescope').grep_zkfiles()<CR>", desc = "Grep ZK Notes" },
  --     { "<leader>zt", "<CMD>ZkTags<CR>", desc = "Select ZK Tags" },
  --   },
  -- },
  {
    "renerocksai/telekasten.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = {
      home = vim.env.HOME .. "/Dropbox/zettelkasten",
      daily = vim.env.HOME .. "/Dropbox/zettelkasten/journal/daily",
      image_subdir = "images",

      templates = vim.env.HOME .. "/Dropbox/zettelkasten/templates",
      template_new_note = vim.env.HOME .. "/Dropbox/zettelkasten/templates/new_note.md",
      template_new_daily = vim.env.HOME .. "/Dropbox/zettelkasten/templates/new_daily.md",
      extension = ".md",

      new_note_filename = "title-uuid",
      uuid_sep = "_",
      uuid_type = "rand",

      sort = "modified",
      install_syntax = false,
      tag_notation = ":tag:",

      show_tags_theme = "cursor",
      media_extensions = {
        ".png",
        ".jpg",
        ".bmp",
        ".gif",
        ".pdf",
        ".mp4",
        ".webm",
        ".webp",
      },
      filename_space_subst = "_",
      auto_set_filetype = false, -- Do not set .md files to telekasten filetype for syntax to work
    },
    enabled = true,
    ft = { "markdown" },
    keys = {
      {
        "<leader>z/",
        "<CMD>lua require('telekasten').find_notes({ with_live_grep = true })<CR>",
        desc = "Search ZK Notes",
      },
      { "<leader>zn", "<CMD>Telekasten new_note<CR>", desc = "New ZK Notes" },
      { "<leader>zt", "<CMD>Telekasten show_tags<CR>", desc = "List ZK Tags" },
      { "<leader>zd", "<CMD>Telekasten follow_link<CR>", desc = "Follow Link" },
      { "<leader>zf", "<CMD>Telekasten find_notes<CR>", desc = "Find ZK Notes" },
      { "<leader>zl", "<CMD>Telekasten insert_link<CR>", desc = "Insert ZK Link" },
      {
        "<leader>zT",
        "<CMD>lua require('telekasten').toggle_todo({ v = true })<CR>",
        desc = "Convert to TODO list",
        mode = { "n", "v" },
      },
      { "<leader>zI", "<CMD>lua require('telekasten').insert_img_link({ i=true })<CR>", desc = "Insert Image Link" },
      -- { "<leader>z/", "<CMD>lua require('telekasten').find_notes({with_live_grep:true})<CR>", desc = "Search ZK Notes" },
    },
  },
  --  [markdown markmap]
  --  https://github.com/Zeioth/markmap.nvim
  {
    "Zeioth/markmap.nvim",
    build = "yarn global add markmap-cli",
    cmd = { "MarkmapOpen", "MarkmapSave", "MarkmapWatch", "MarkmapWatchStop" },
    opts = {
      html_output = "", -- (default) Setting a empty string "" here means: [Current buffer path].html
      hide_toolbar = false, -- (default)
      grace_period = 3600000, -- (default) Stops markmap watch after 60 minutes. Set it to 0 to disable the grace_period.
    },
    config = function(_, opts)
      require("markmap").setup(opts)
    end,
  },
  -- {
  --   "folke/paint.nvim",
  --     config = function()
  --       require("paint").setup({
  --         ---@type PaintHighlight[]
  --         highlights = {
  --           {
  --             -- filter can be a table of buffer options that should match,
  --             -- or a function called with buf as param that should return true.
  --             -- The example below will paint @something in comments with Constant
  --             filter = { filetype = "lua" },
  --             pattern = "%s%-%-%-%s(@%w+)",
  --             hl = "Constant",
  --           },
  --         },
  --       })
  --     end,
  --   -- config = function()
  --   --   local hlmap = {
  --   --     ["^#%s+(.-)%s*$"] = "Operator",
  --   --     ["^##%s+(.-)%s*$"] = "Type",
  --   --     ["^###%s+(.-)%s*$"] = "String",
  --   --     ["^####%s+(.-)%s*$"] = "Constant",
  --   --     ["^#####%s+(.-)%s*$"] = "Number",
  --   --     ["^######%s+(.-)%s*$"] = "Error",
  --   --   }
  --   --
  --   --   local highlights = {}
  --   --   for pattern, hl in pairs(hlmap) do
  --   --     table.insert(highlights, {
  --   --       filter = { filetype = "markdown" },
  --   --       pattern = pattern,
  --   --       hl = hl,
  --   --     })
  --   --   end
  --   --
  --   --   require("paint").setup({
  --   --     ---@type PaintHighlight[]
  --   --     highlights = highlights,
  --   --   })
  --   -- end,
  --   filedtype = { "markdown" },
  --   lazy = false,
  -- },
}
