-- local install_root_dir = vim.fn.stdpath("data") .. "/mason"
-- local extension_path = install_root_dir .. "/packages/codelldb/extension/"
-- local codelldb_path = extension_path .. "adapter/codelldb"
-- local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

local function get_codelldb()
  local mason_registry = require("mason-registry")
  local codelldb = mason_registry.get_package("codelldb")
  local extension_path = codelldb:get_install_path() .. "/extension/"
  local codelldb_path = extension_path .. "adapter/codelldb"
  local liblldb_path = vim.fn.has("mac") == 1 and extension_path .. "lldb/lib/liblldb.dylib"
    or extension_path .. "lldb/lib/liblldb.so"
  return codelldb_path, liblldb_path
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "rust", "ron", "toml" })
    end,
  },
  -- {
  --   "williamboman/mason.nvim",
  --   dependencies = { "williamboman/mason-lspconfig.nvim", "neovim/nvim-lspconfig" },
  --   opts = function(_, opts)
  --     vim.list_extend(opts.ensure_installed, { "codelldb" })
  --   end,
  -- },
  {
    "michaelb/sniprun",
    branch = "master",
    cmd = "SnipRun",
    build = "sh install.sh",
    -- do 'sh install.sh 1' if you want to force compile locally
    -- (instead of fetching a binary from the github release). Requires Rust >= 1.65

    config = function()
      require("sniprun").setup({
        interpreter_options = {
          Rust_original = {
            compiler = "rustc",
          },
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "simrat39/rust-tools.nvim", "rust-lang/rust.vim" },
    opts = {
      servers = {
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
              },
              -- Add clippy lints for Rust.
              checkOnSave = {
                allFeatures = true,
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
            },
          },
        },
      },
      setup = {
        rust_analyzer = function(_, opts)
          local lsp_utils = require("plugins.lsp.utils")
          lsp_utils.on_attach(function(client, buffer)
            local map = function(mode, lhs, rhs, desc)
              if desc then
                desc = desc
              end
              vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, buffer = buffer, noremap = true })
            end
            -- stylua: ignore
            if client.name == "rust_analyzer" then
              map("n", "<leader>le", "<cmd>RustRunnables<cr>", "Runnables")
              map("n", "<leader>ll", function() vim.lsp.codelens.run() end, "Code Lens" )
              map("n", "<leader>lt", "<cmd>Cargo test<cr>", "Cargo test" )
              map("n", "<leader>lr", "<cmd>Cargo run<cr>", "Cargo run" )
            end
          end)

          -- Creates an autocmd for Cargo.toml file to register crates keymappings
          vim.api.nvim_create_autocmd({ "BufEnter" }, {
            pattern = { "Cargo.toml" },
            callback = function(event)
              local bufnr = event.buf

              -- Register keymappings
              local wk = require("which-key")
              local keys = { mode = { "n", "v" }, ["<leader>lc"] = { name = "+Crates" } }
              wk.register(keys)

              local map = function(mode, lhs, rhs, desc)
                if desc then
                  desc = desc
                end
                vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, buffer = bufnr, noremap = true })
              end
              map("n", "<leader>lcy", "<cmd>lua require'crates'.open_repository()<cr>", "Open Repository")
              map("n", "<leader>lcp", "<cmd>lua require'crates'.show_popup()<cr>", "Show Popup")
              map("n", "<leader>lci", "<cmd>lua require'crates'.show_crate_popup()<cr>", "Show Info")
              map("n", "<leader>lcf", "<cmd>lua require'crates'.show_features_popup()<cr>", "Show Features")
              map("n", "<leader>lcd", "<cmd>lua require'crates'.show_dependencies_popup()<cr>", "Show Dependencies")
            end,
          })

          require("rust-tools").setup({
            tools = {
              hover_actions = { border = "solid" },
              on_initialized = function()
                -- vim.api.nvim_create_autocmd(
                --   { "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" },
                --   {
                --     pattern = { "*.rs" },
                --     callback = function()
                --       vim.lsp.codelens.refresh()
                --     end,
                --   }
                -- )
                local map = function(mode, lhs, rhs, desc)
                  if desc then
                    desc = desc
                  end
                  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, buffer = bufnr, noremap = true })
                end
                map(
                  "n",
                  "<leader>lcc",
                  "<cmd>lua require'rust-tools'.open_cargo_toml.open_cargo_toml()<cr>",
                  "Open Cargo.toml"
                )

                vim.cmd([[
                  augroup RustLSP
                    autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
                  augroup END
                ]])
              end,
            },
            server = opts,
            dap = {
              adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
            },
          })
          return true
        end,
      },
    },
  },
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        cmp = {
          enabled = true,
        },
      },
    },
    config = function(_, opts)
      local crates = require("crates")
      crates.setup(opts)
      require("cmp").setup.buffer({
        sources = { { name = "crates" } },
      })
      crates.show()
    end,
  },
  {
    "mfussenegger/nvim-dap",
    opts = {
      setup = {
        codelldb = function()
          local codelldb_path, _ = get_codelldb()
          local dap = require("dap")
          dap.adapters.codelldb = {
            type = "server",
            port = "${port}",
            executable = {
              command = codelldb_path,
              args = { "--port", "${port}" },

              -- On windows you may have to uncomment this:
              -- detached = false,
            },
          }
          dap.configurations.cpp = {
            {
              name = "Launch file",
              type = "codelldb",
              request = "launch",
              program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
              end,
              cwd = "${workspaceFolder}",
              stopOnEntry = false,
            },
          }

          dap.configurations.c = dap.configurations.cpp
          dap.configurations.rust = dap.configurations.cpp
        end,
      },
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "rouge8/neotest-rust",
    },
    opts = function(_, opts)
      vim.list_extend(opts.adapters, {
        require("neotest-rust"),
      })
    end,
  },
}
