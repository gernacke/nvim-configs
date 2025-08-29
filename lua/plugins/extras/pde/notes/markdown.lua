return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "copilot-chat" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      heading = {
        -- backgrounds = {}, -- remove the background color across the lines
        border = true,
      },
      indent = { enabled = true, skip_heading = true, skip_level = 0 },
    },
  },
  {
    "jakewvincent/mkdnflow.nvim",
    ft = { "markdown" },
    rocks = "luautf8",
    opts = {},
    enabled = false,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
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
        function()
          Snacks.picker.grep({
            cwd = os.getenv("HOME") .. "/Dropbox/zettelkasten/",
            prompt = " 󱞁 Zettelkasten Grep 󰅂 ",
          })
        end,
        desc = "Grep",
      },
      { "<leader>zn", "<CMD>Telekasten new_note<CR>", desc = "New ZK Notes" },
      { "<leader>zt", "<CMD>Telekasten show_tags<CR>", desc = "List ZK Tags" },
      { "<leader>zd", "<CMD>Telekasten follow_link<CR>", desc = "Follow Link" },
      -- { "<leader>zf", "<CMD>Telekasten find_notes<CR>", desc = "Find ZK Notes" },
      {
        "<leader>zf",
        function()
          Snacks.picker.files({
            cwd = os.getenv("HOME") .. "/Dropbox/zettelkasten/",
            prompt = " 󱞁 Zettelkasten Notes 󰅂 ",
          })
        end,
        desc = "Zettelkasten Notes",
      },
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
}
