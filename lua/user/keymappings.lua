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
        ["<c-j>"] = "<Plug>(completion_next_source)",
        ["<c-k>"] = "<Plug>(completion_prev_source)"
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
        ["<leader>ps"]  = "<CMD>PackerSync<CR>",
        -- ["<leader>S"]   = "<Plug>(SearchNormal)",
        -- ["<c-w>k"] = "<c-w>K",
        -- ["<c-w>j"] = "<c-w>J",
        -- ["<c-w>h"] = "<c-w>H",
        -- ["<c-w>l"] = "<c-w>L",
        -- ["gx"] = "<Cmd>call OpenURLUnderCursor()<CR>",
        ["<UP>"]        = "<c-w>3-",
        ["<DOWN>"]      = "<c-w>3+",
        ["<LEFT>"]      = "<c-w>3<",
        ["<RIGHT>"]     = "<c-w>3>",
        -- ["<leader>-"] = ":wincmd _<cr>:wincmd |<cr>",
        -- ["<leader>="] = ":wincmd =<cr>",
        -- Vim-tmux-runner configs --
        ["<leader>vxp"] = "<CMD>VtrAttachToPane<CR>",
        ["<leader>vxl"] = "<CMD>VtrSendLinesToRunner<CR>",
        ["<leader>vxo"] = "<CMD>VtrOpenRunner {'orientation': 'h', 'percentage': 50}<CR>",
        -- Easy Align --
        ["ga"]          = {
            "<Plug>(EasyAlign)",
            { noremap = false, silent = false },
        },
        -- ["<A-,>"] = "<cmd>BufferPrevious<CR>",
        -- ["<A-.>"] = "<cmd>BufferNext<CR>",
        -- ["<A-<>"] = "<cmd>BufferMovePrevious<CR>",
        -- ["<A->>"] = "<cmd>BufferMoveNext<CR>",
        -- ["<A-c>"] = "<cmd>BufferClose<CR>",
        -- ["<A-s>"] = "<cmd>BufferPick<CR>",
        -- 'szw/vim-maximizer' mappings --
        ["<leader>ld"]  = "<cmd>lua vim.lsp.util.show_line_diagnostics()<cr>",
    },
    visual_mode       = {
        [";"]         = ":",
        [":"]         = ";",
        ["<leader>h"] = "<cmd>noh<CR>",
        ["L"]         = "g_",
        ["H"]         = "^",
        ["p"]         = "pgvy",
        -- ["<leader>S"]  = "<Plug>(SearchVisual)",
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
        -- ["w!!"] = "execute 'silent! write !sudo tee % >/dev/null' <bar> edit!"
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

-- return M
