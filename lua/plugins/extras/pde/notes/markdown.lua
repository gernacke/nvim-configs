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
    lazy = false,
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

      show_tags_theme = "dropdown",
    },
    enabled = true,
    ft = { "markdown" },
    keys = {
      { "<leader>z/", "<CMD>lua require('telekasten').find_notes({ with_live_grep = true })<CR>", desc = "Search ZK Notes" },
      { "<leader>zn", "<CMD>Telekasten new_note<CR>", desc = "New ZK Notes" },
      { "<leader>zt", "<CMD>Telekasten show_tags<CR>", desc = "List ZK Tags" },
      { "<leader>zf", "<CMD>Telekasten find_notes<CR>", desc = "Find ZK Notes" },
      { "<leader>zl", "<CMD>Telekasten insert_link<CR>", desc = "Insert ZK Link" },
      { "<leader>zT", "<CMD>lua require('telekasten').toggle_todo({ v = true })<CR>", desc = "Convert to TODO list" },
      { "<leader>zI", "<CMD>lua require('telekasten').insert_img_link({ i=true })<CR>", desc = "Insert Image Link" },
      -- { "<leader>z/", "<CMD>lua require('telekasten').find_notes({with_live_grep:true})<CR>", desc = "Search ZK Notes" },
    },
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     -- make sure mason installs the server
  --     servers = {
  --       marksman = {},
  --       zk = {
  --         root_dir = require("lspconfig.util").root_pattern { ".git", ".zk" },
  --       },
  --     },
  --   },
  -- },
  -- {
  --   "epwalsh/obsidian.nvim",
  --   opts = {
  --     dir = vim.env.HOME .. "/obsidian",
  --     completion = {
  --       nvim_cmp = true,
  --     },
  --   },
  --   ft = { "markdown" },
  -- },
  -- { "toppair/peek.nvim", run = "deno task --quiet build:fast" },
  -- glow.nvim
  -- https://github.com/rockerBOO/awesome-neovim#markdown-and-latex
}
