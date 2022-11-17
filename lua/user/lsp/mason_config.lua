local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
	return
end

-- TODO check out grammarly lsp server
local servers = {
	"sumneko_lua",
	-- "cssls",
	"html",
	-- "tsserver",
	"pyright",
	"bashls",
	"jsonls",
	"powershell_es",
	"yamlls",
}

local settings = {
	ui = {
		border = "rounded",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

mason.setup(settings)
mason_lspconfig.setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

	if server == "jsonls" then
		local jsonls_opts = require("user.lsp.settings.jsonls")
		opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	end

	if server == "yamlls" then
		local yamlls_opts = require("user.lsp.settings.yamlls")
		opts = vim.tbl_deep_extend("force", yamlls_opts, opts)
	end

	if server == "sumneko_lua" then
		local l_status_ok, lua_dev = pcall(require, "lua-dev")
		if not l_status_ok then
			return
		end
		-- local sumneko_opts = require "user.lsp.settings.sumneko_lua"
		-- opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
		-- opts = vim.tbl_deep_extend("force", require("lua-dev").setup(), opts)
		local luadev = lua_dev.setup({
			--   -- add any options here, or leave empty to use the default settings
			-- lspconfig = opts,
			lspconfig = {
				on_attach = opts.on_attach,
				capabilities = opts.capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							-- library = {
							-- 	[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							-- 	[vim.fn.stdpath("config") .. "/lua"] = true,
							-- },
							checkThirdParty = false, -- This line stops LSP asking for work environment setup
						},
					},
				},
			},
		})
		lspconfig.sumneko_lua.setup(luadev)
		goto continue
	end

	-- if server == "tsserver" then
	--   local tsserver_opts = require "user.lsp.settings.tsserver"
	--   opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
	-- end

	if server == "pyright" then
		local pyright_opts = require("user.lsp.settings.pyright")
		opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	end

	--[[ if server == "solc" then
    local solc_opts = require "user.lsp.settings.solc"
    opts = vim.tbl_deep_extend("force", solc_opts, opts)
  end

  if server == "emmet_ls" then
    local emmet_ls_opts = require "user.lsp.settings.emmet_ls"
    opts = vim.tbl_deep_extend("force", emmet_ls_opts, opts)
  end

  if server == "zk" then
    local zk_opts = require "user.lsp.settings.zk"
    opts = vim.tbl_deep_extend("force", zk_opts, opts)
  end

  if server == "jdtls" then
    goto continue
  end

  if server == "rust_analyzer" then
    local rust_opts = require "user.lsp.settings.rust"
    -- opts = vim.tbl_deep_extend("force", rust_opts, opts)
    local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
    if not rust_tools_status_ok then
      return
    end

    rust_tools.setup(rust_opts)
    goto continue
  end ]]

	lspconfig[server].setup(opts)
	::continue::
end

-- require("lspconfig").motoko.setup {}

-- local M = {}

-- function M.config()

-- end

-- function M.setup()
--   local config = {
--     ui = {
--       border = "rounded",
--       keymaps = {
--         toggle_package_expand = "<CR>",
--         install_package = "i",
--         update_package = "u",
--         check_package_version = "c",
--         update_all_packages = "U",
--         check_outdated_packages = "C",
--         uninstall_package = "X",
--         cancel_installation = "<C-c>",
--         apply_language_filter = "<C-f>",
--       },
--     },
--     log_level = vim.log.levels.INFO,
--     max_concurrent_installers = 4,

--     github = {
--       -- The template URL to use when downloading assets from GitHub.
--       -- The placeholders are the following (in order):
--       -- 1. The repository (e.g. "rust-lang/rust-analyzer")
--       -- 2. The release version (e.g. "v0.3.0")
--       -- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
--       download_url_template = "https://github.com/%s/releases/download/%s/%s",
--     },
--   }

--   local status_ok, mason = pcall(reload, "mason")
--   if not status_ok then
--     return
--   end

--   mason.setup(config)
-- end

-- return M
