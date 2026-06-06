local M = {}

local lsp_utils = require("plugins.lsp.utils")
local icons = require("config.icons")

local function lsp_init()
  local signs = {
    { name = "DiagnosticSignError", text = icons.diagnostics.Error },
    { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
    { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
    { name = "DiagnosticSignInfo", text = icons.diagnostics.Info },
  }
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  -- Ignore Rust LSP Warnings: rust_analyzer: -32802: server cancelled the request
  for _, method in ipairs({ "textDocument/diagnostic", "workspace/diagnostic" }) do
    local default_diagnostic_handler = vim.lsp.handlers[method]
    vim.lsp.handlers[method] = function(err, result, context, config)
      if err ~= nil and err.code == -32802 then
        return
      end
      return default_diagnostic_handler(err, result, context, config)
    end
  end

  -- LSP handlers configuration
  local config = {
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
    },

    diagnostic = {
      virtual_text = false,
      virtual_text = {
        spacing = 4,
        prefix = "⏹️",
        severity = {
          min = vim.diagnostic.severity.ERROR,
        },
      },
      signs = {
        active = signs,
      },
      underline = false,
      update_in_insert = false,
      severity_sort = true,
      float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
      -- virtual_lines = true,
    },
  }

  -- Diagnostic configuration
  vim.diagnostic.config(config.diagnostic)

  -- Neovim 0.11 no longer routes vim.lsp.buf.hover/signature_help through
  -- vim.lsp.handlers, so the old vim.lsp.with() override is a no-op and the
  -- border is lost. Wrap the functions to apply our float config instead.
  local float_opts = { focusable = config.float.focusable, border = config.float.border }
  vim.lsp.buf.hover = (function(orig)
    return function(opts)
      return orig(vim.tbl_extend("force", float_opts, opts or {}))
    end
  end)(vim.lsp.buf.hover)
  vim.lsp.buf.signature_help = (function(orig)
    return function(opts)
      return orig(vim.tbl_extend("force", float_opts, opts or {}))
    end
  end)(vim.lsp.buf.signature_help)
end

function M.setup(_, opts)
  lsp_utils.on_attach(function(client, bufnr)
    require("plugins.lsp.format").on_attach(client, bufnr)
    require("plugins.lsp.keymaps").on_attach(client, bufnr)
  end)

  lsp_init() -- diagnostics, handlers

  local servers = opts.servers
  local capabilities = lsp_utils.capabilities()

  local function setup(server)
    local server_opts = vim.tbl_deep_extend("force", {
      capabilities = capabilities,
    }, servers[server] or {})

    if opts.setup[server] then
      if opts.setup[server](server, server_opts) then
        return
      end
    elseif opts.setup["*"] then
      if opts.setup["*"](server, server_opts) then
        return
      end
    end
    require("lspconfig")[server].setup(server_opts)
  end

  -- Add bun for Node.js-based servers
  local lspconfig_util = require("lspconfig.util")
  local add_bun_prefix = require("plugins.lsp.bun").add_bun_prefix
  lspconfig_util.on_setup = lspconfig_util.add_hook_before(lspconfig_util.on_setup, add_bun_prefix)

  -- get all the servers that are available thourgh mason-lspconfig
  local have_mason, mlsp = pcall(require, "mason-lspconfig")
  local all_mslp_servers = {}
  if have_mason then
    all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
  end

  local ensure_installed = {} ---@type string[]
  for server, server_opts in pairs(servers) do
    if server_opts then
      server_opts = server_opts == true and {} or server_opts
      -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
      if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
        setup(server)
      else
        ensure_installed[#ensure_installed + 1] = server
      end
    end
  end

  if have_mason then
    mlsp.setup({ ensure_installed = ensure_installed })
    mlsp.setup_handlers({ setup })
  end
end

return M
