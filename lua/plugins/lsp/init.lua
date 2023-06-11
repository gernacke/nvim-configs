return {
  { "smjonas/inc-rename.nvim", config = true },
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      {
        "folke/neodev.nvim",
        opts = {
          library = { plugins = { "neotest", "nvim-dap-ui" }, types = true },
        },
      },
      { "j-hui/fidget.nvim", config = true },
      { "smjonas/inc-rename.nvim", config = true },
      "simrat39/rust-tools.nvim",
      "rust-lang/rust.vim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = { callSnippet = "Replace" },
              telemetry = { enable = false },
              hint = {
                enable = false,
              },
            },
          },
        },
        dockerls = {},
      },
      setup = {},
    },
    config = function(plugin, opts)
      require("plugins.lsp.servers").setup(plugin, opts)
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    ensure_installed = {
      "stylua",
      "ruff",
      "bash-debug-adapter",
      "bash-language-server",
      "debugpy",
      "codelldb",
      "json-lsp",
    },
    config = function(plugin)
      require("mason").setup()
      local mr = require "mason-registry"
      for _, tool in ipairs(plugin.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    dependencies = { "mason.nvim" },
    config = function()
      local nls = require "null-ls"
      nls.setup {
        sources = {
          nls.builtins.formatting.prettier.with {
            extra_filetypes = { "toml", "solidity" },
            extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
          },
          nls.builtins.formatting.black.with { extra_args = { "--fast" } },
          nls.builtins.formatting.stylua,
          --   formatting.stylua.with({ extra_args = { "--indent-type", "Spaces", "--indent-width", "4" } }),
          nls.builtins.formatting.shfmt,
          nls.builtins.formatting.google_java_format,
          nls.builtins.diagnostics.ruff.with { extra_args = { "--max-line-length=180" } },
          nls.builtins.diagnostics.flake8,
          nls.builtins.diagnostics.shellcheck,
        },
      }
    end,
  },
}
