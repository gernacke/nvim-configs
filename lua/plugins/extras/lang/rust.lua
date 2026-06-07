return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "rust", "ron", "toml" })
    end,
  },
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
    opts = {
      setup = {
        rust_analyzer = function()
          return true -- skip lspconfig setup: handled by rustaceanvim
        end,
      },
    },
  },
  {
    "mrcjkb/rustaceanvim",
    -- v9+ drops Neovim 0.11 support; stay on the v8 line for 0.11 compatibility.
    version = "^8.0.5",
    lazy = false,
    init = function()
      vim.g.rustaceanvim = {
        tools = {
          -- Applies to all rustaceanvim floats (explainError, expandMacro, etc.)
          -- except hover_actions which has its own border below.
          -- Padding isn't configurable here: these use open_floating_preview
          -- (not nui.nvim), so content sits flush against the border.
          float_win_config = {
            border = "rounded",
            max_width = 80,
          },
          hover_actions = { border = "solid" },
          -- Enable inlay hints only after rust-analyzer finishes indexing
          on_initialized = function(status)
            if status.health == "ok" then
              vim.lsp.inlay_hint.enable(true)
            end
          end,
        },
        server = {
          on_attach = function(_, bufnr)
            local map = function(mode, lhs, rhs, desc)
              vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, buffer = bufnr, noremap = true })
            end
            map("n", "<leader>lE", function() vim.cmd.RustLsp("runnables") end, "Runnables")
            map("n", "<leader>lt", function() vim.cmd.RustLsp("testables") end, "Testables")
            map("n", "<leader>lr", function() vim.cmd.RustLsp({ "runnables", bang = true }) end, "Re-run Last")
            map("n", "<leader>ll", vim.lsp.codelens.run, "Code Lens")
            map("n", "<leader>lcc", function() vim.cmd.RustLsp("openCargo") end, "Open Cargo.toml")
            map("n", "<leader>lch", function()
              vim.lsp.inlay_hint.enable(
                not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
                { bufnr = bufnr }
              )
            end, "Toggle Inlay Hints")
            map("n", "<leader>lA", function() vim.cmd.RustLsp({ "hover", "actions" }) end, "Hover Actions")
            map("n", "<leader>lR", function() vim.cmd.RustAnalyzer("restart") end, "Restart rust-analyzer")
            map("n", "<leader>le", function() vim.cmd.RustLsp("explainError") end, "Explain Error")
            map("n", "<leader>ld", function() vim.cmd.RustLsp({ "renderDiagnostic", "current" }) end, "Render Diagnostic")
            map("n", "<leader>ln", function() vim.cmd.RustLsp({ "renderDiagnostic", "cycle" }) end, "Cycle Diagnostics")
            map("n", "<leader>lD", function() vim.cmd.RustLsp("debuggables") end, "Debuggables")
            map("n", "<leader>lT", function() vim.cmd.RustLsp("relatedTests") end, "Related Tests")
            map("n", "<leader>lo", function() vim.cmd.RustLsp("openDocs") end, "Open Docs")
            map("n", "<leader>lk", function() vim.cmd.RustLsp({ "moveItem", "up" }) end, "Move Item Up")
            map("n", "<leader>lj", function() vim.cmd.RustLsp({ "moveItem", "down" }) end, "Move Item Down")
            map({ "n", "v" }, "<leader>ca", function() vim.cmd.RustLsp("codeAction") end, "Code Action")
            map("n", "J", function() vim.cmd.RustLsp("joinLines") end, "Join Lines")

            vim.api.nvim_create_autocmd("CursorHold", {
              buffer = bufnr,
              callback = function() vim.lsp.buf.document_highlight() end,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter" }, {
              buffer = bufnr,
              callback = function() vim.lsp.buf.clear_references() end,
            })
          end,
          default_settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
              },
              checkOnSave = true,
              check = {
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
        dap = {
          autoload_configurations = true,
        },
      }
    end,
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

      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "Cargo.toml",
        callback = function(event)
          local bufnr = event.buf
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, buffer = bufnr, noremap = true })
          end
          map("n", "<leader>lcy", function() crates.open_repository() end, "Open Repository")
          map("n", "<leader>lcp", function() crates.show_popup() end, "Show Popup")
          map("n", "<leader>lci", function() crates.show_crate_popup() end, "Show Info")
          map("n", "<leader>lcf", function() crates.show_features_popup() end, "Show Features")
          map("n", "<leader>lcd", function() crates.show_dependencies_popup() end, "Show Dependencies")
        end,
      })
    end,
  },
  {
    "mfussenegger/nvim-dap",
    opts = {
      setup = {
        codelldb = function()
          local mason_registry = require("mason-registry")
          local codelldb = mason_registry.get_package("codelldb")
          local extension_path = codelldb:get_install_path() .. "/extension/"
          local codelldb_path = extension_path .. "adapter/codelldb"
          local dap = require("dap")
          dap.adapters.codelldb = {
            type = "server",
            port = "${port}",
            executable = {
              command = codelldb_path,
              args = { "--port", "${port}" },
            },
          }
          -- C/C++ DAP configs (Rust is handled by rustaceanvim)
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
