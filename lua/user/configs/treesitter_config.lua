local M = {}

-- TODO FIX THE ERROR:
-- Error detected while processing /Users/ger/.config/nvim/init.lua:
-- E5113: Error while calling lua chunk: ...e/nvim/site/pack/packer/start/packer.nvim/lua/packer.lua:1026: ...ua/neorg/modules/core/integrations/treesitter/module.lua:50: Unable to load nvim-treesitter.ts_utils :(
-- stack traceback:
--         [C]: in function 'error'
--         ...e/nvim/site/pack/packer/start/packer.nvim/lua/packer.lua:1026: in function 'startup'
--         /Users/ger/.config/nvim/lua/user/plugins.lua:312: in function 'setup'
--         /Users/ger/.config/nvim/init.lua:4: in main chunk
-- Error detected while processing /Users/ger/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects/plugin/nvim-treesitter-textobjects.vim:
-- line    3:
-- E5108: Error executing lua ...eesitter-textobjects/lua/nvim-treesitter-textobjects.lua:1: loop or previous error loading module 'nvim-treesitter.query'
-- stack traceback:
--         [C]: in function 'require'
--         ...eesitter-textobjects/lua/nvim-treesitter-textobjects.lua:1: in main chunk
--         [C]: in function 'require'
--         [string ":lua"]:1: in main chunk
-- Error detected while processing /Users/ger/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring/plugin/ts_context_commentstring.vim:
-- line    1:
-- E5108: Error executing lua [string ":lua"]:1: attempt to index a boolean value
-- stack traceback:
--         [string ":lua"]:1: in main chunk
-- Error detected while processing BufReadPost Autocommands for "*":
-- E5108: Error executing lua ...m/site/pack/packer/start/packer.nvim/lua/packer/load.lua:171: Vim(echomsg):E114: Missing quote: "Error in packer_compiled: ...m/site/pack/packer/start/packer.nvim/lua/packer/load.lua:139: Vim(
-- packadd):E5113: Error while calling lua chunk: ...ck/packer/opt/nvim-treesitter/plugin/nvim-treesitter.lua:9: loop or previous error loading module 'nvim-treesitter'
-- stack traceback:
--         [C]: in function 'cmd'
--         ...m/site/pack/packer/start/packer.nvim/lua/packer/load.lua:171: in function <...m/site/pack/packer/start/packer.nvim/lua/packer/load.lua:167>
--         [string ":lua"]:1: in main chunk
-- [packer.nvim] [ERROR 09:20:31] packer.lua:1025: Failure running setup function: "...ua/neorg/modules/core/integrations/treesitter/module.lua:50: Unable to load nvim-treesitter.ts_utils :("

function M.setup()
    -- local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

    -- parser_configs.norg = {
    --     install_info = {
    --         url = "https://github.com/nvim-neorg/tree-sitter-norg",
    --         files = { "src/parser.c", "src/scanner.cc" },
    --         branch = "main",
    --     },
    -- }

    require("nvim-treesitter.configs").setup {
        ensure_installed = { "bash", "c", "javascript", "json", "lua", "python", "typescript", "css", "rust", "java",
            "yaml", "norg",
        }
        , -- one of "all", "maintained" (parsers with maintainers), or a list of languages
        highlight = {
            enable = true,
            disable = { "css" },
            additional_vim_regex_highlighting = true,
            -- custom_captures = {["new_import"] = "CustomImportName"}
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "gnn",
                node_incremental = "grn",
                scope_incremental = "grc",
                node_decremental = "grm",
            },
        },
        indent = { enable = true },
        playground = {
            enable = true,
            disable = {},
            updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
            persist_queries = false, -- Whether the query persists across vim sessions
        },
        rainbow = { enable = true, extended_mode = true },
        textobjects = {
            select = {
                enable = true,

                -- Automatically jump forward to textobj, similar to targets.vim
                lookahead = true,

                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                },
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
            },
            swap = {
                enable = true,
                swap_next = { ["<Leader>rx"] = "@parameter.inner" },
                swap_previous = { ["<Leader>rX"] = "@parameter.inner" },
            },
            lsp_interop = {
                enable = true,
                border = "none",
                -- peek_definition_code = {
                --     ["df"] = "@function.outer",
                --     ["dF"] = "@class.outer",
                -- },
            },
            -- refactor = {
            --     highlight_definitions = {enable = true},
            --     highlight_current_scope = {enable = true},
            --     smart_rename = {
            --         enable = true,
            --         keymaps = {smart_rename = "grr"}
            --         -- keymaps = {smart_rename = "<leader>rn"}
            --     },
            --     navigation = {
            --         enable = true,
            --         keymaps = {
            --             goto_definition = "gnd",
            --             list_definitions = "gnD",
            --             list_definitions_toc = "gO",
            --             goto_next_usage = "<a-*>",
            --             goto_previous_usage = "<a-#>"
            --         }
            --     }
            -- }
        },
        context_commentstring = { enable = true, enable_autocmd = false,},
        autopairs = { enable = true },
        textsubjects = {
            enable = true,
            keymaps = {
                ["."] = "textsubjects-smart",
                [";"] = "textsubjects-container-outer",
            },
        },
        matchup = { enable = true },
    }
end

return M
