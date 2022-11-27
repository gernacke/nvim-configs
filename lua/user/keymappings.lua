local M = {}

local opts = { noremap = true, silent = false }

local generic_opts = {
    insert_mode = opts,
    normal_mode = opts,
    visual_mode = opts,
    visual_block_mode = opts,
    command_mode = opts,
    term_mode = { silent = false }
}

local mode_adapters = {
    insert_mode = "i",
    normal_mode = "n",
    term_mode = "t",
    visual_mode = "v",
    visual_block_mode = "x",
    command_mode = "c"
}

local keymappings = {
    insert_mode       = {
        -- ["<c-j>"] = "<Plug>(completion_next_source)",
        -- ["<c-k>"] = "<Plug>(completion_prev_source)"
    },
    normal_mode       = {
        [";"]           = ":",
        [":"]           = ";",
        ["<c-w>z"]      = "<c-w>_",
        ["L"]           = "g_",
        ["H"]           = "^",
        ["zh"]          = "zH",     -- Moves left half screen
        ["zl"]          = "zL",     -- Moves right half screen
        ["Y"]           = "y$",
        ["<c-q>"]       = ":call QuickFixToggle()<CR>",
        ["<UP>"]        = "<c-w>3-",
        ["<DOWN>"]      = "<c-w>3+",
        ["<LEFT>"]      = "<c-w>3<",
        ["<RIGHT>"]     = "<c-w>3>",
        ["gs"]          = {
            "<Plug>(leap-cross-window)",
            { noremap = false, silent = false },
        },
        ["ga"]          = {
            "<Plug>(EasyAlign)",
            { noremap = false, silent = false },
        },
        -- Hop keybindings
        -- ["f"]           = "<cmd>HopChar1AC<cr>",
        -- ["N"]           = "<cmd>HopPattern<cr>",
        -- ["<LEADER>j"]   = "<cmd>HopLineAC<cr>",
        -- ["<LEADER>k"]   = "<cmd>HopLineBC<cr>",
        -- ["<leader>-"] = ":wincmd _<cr>:wincmd |<cr>",
        -- ["<leader>="] = ":wincmd =<cr>",
    },
    visual_mode       = {
        [";"]         = ":",
        [":"]         = ";",
        ["<leader>h"] = "<cmd>noh<CR>",
        ["L"]         = "g_",
        ["H"]         = "^",
        ["p"]         = "pgvy",
        ["f"]         = "<cmd>HopChar1AC<cr>",
        ["N"]         = "<cmd>HopPattern<cr>",
    },
    term_mode         = {
        -- ['<C-w><C-o>'] = '<C-\\><C-n> :MaximizerToggle!<CR>',
        -- ['<C-h>'] = '<C-\\><C-n><C-w>h',
        -- ['<C-j>'] = '<C-\\><C-n><C-w>j',
        -- ['<C-k>'] = '<C-\\><C-n><C-w>k',
        -- ['<C-l>'] = '<C-\\><C-n><C-w>l',
        -- ['jk'] = '<C-\\><C-n>'
    },
    command_mode      = {
        ["<C-j>"] = {
            'pumvisible() ? "\\<C-n>" : "\\<C-j>"',
            { expr = true, noremap = true }
        },
        ["<C-k>"] = {
            'pumvisible() ? "\\<C-p>" : "\\<C-k>"',
            { expr = true, noremap = true }
        }
    },
    visual_block_mode = {
        ["ga"] = {
            "<Plug>(EasyAlign)",
            { noremap = false, silent = false },
        },
        ["."]  = {
            "<CMD>normal .<CR>",
            { noremap = true, silent = false },
        },
        ["@"]  = {
            "<cmd><C-u>echo '@'.getcmdline() | execute ':\'<,\'>normal @' . nr2char(getchar())<Cr>'",
            { noremap = false, silent = true }
        }
    }
}

local lsp_keymappings = {

    normal_mode = {
        ["K"]         = "<Cmd>lua vim.lsp.buf.hover()<CR>",
        ["gD"]        = "<Cmd>lua vim.lsp.buf.declaration()<CR>",
        ["gd"]        = "<Cmd>lua vim.lsp.buf.definition()<CR>",
        ["gI"]        = "<Cmd>lua vim.lsp.buf.implementation()<CR>",
        ["gr"]        = "<cmd>lua vim.lsp.buf.references()<CR>",
        ["<leader>k"] = "<Cmd>lua vim.lsp.buf.signature_help()<CR>",
        ["[d"]        = "<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
        ["]d"]        = "<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>",
        ["[e"]        = "<Cmd>Lspsaga diagnostic_jump_next<CR>",
        ["]e"]        = "<Cmd>Lspsaga diagnostic_jump_prev<CR>"
    }
}

function M.set_keymaps(mode, key, val)
    local opt = generic_opts[mode] and generic_opts[mode] or opts
    if type(val) == "table" then
        opt = val[2]
        val = val[1]
    end
    vim.api.nvim_set_keymap(mode, key, val, opt)
end

function M.map(mode, keymaps)
    mode = mode_adapters[mode] and mode_adapters[mode] or mode
    for k, v in pairs(keymaps) do M.set_keymaps(mode, k, v) end
end

function M.setup()
    for mode, mapping in pairs(keymappings) do M.map(mode, mapping) end
end

function M.setup_lsp_mappings()
    for mode, mapping in pairs(lsp_keymappings) do M.map(mode, mapping) end
end

M.setup()

