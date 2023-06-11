local M = {}

local keymap = vim.keymap.set
local opts = { noremap = true, silent = false }

local generic_opts = {
  insert_mode = opts,
  normal_mode = opts,
  visual_mode = opts,
  visual_block_mode = opts,
  command_mode = opts,
  term_mode = { silent = false },
}

local mode_adapters = {
  insert_mode = "i",
  normal_mode = "n",
  term_mode = "t",
  visual_mode = "v",
  visual_block_mode = "x",
  command_mode = "c",
}

local keymappings = {
  insert_mode = {
    -- ["<c-j>"] = "<Plug>(completion_next_source)",
    -- ["<c-k>"] = "<Plug>(completion_prev_source)"

    -- Add undo break-points
    [","] = ",<c-g>u",
    ["."] = ".<c-g>u",
    [";"] = ";<c-g>u",
    ["[["] = "<ESC>:lua require('telekasten').insert_link({ i=true })<CR>",
    ["[#"] = "<cmd>lua require('telekasten').show_tags({i = true})<cr>",

    -- Move lines
    -- ["<A-j>"] = "<Esc>:m .+1<CR>==gi",
    -- ["<A-k>"] = "<Esc>:m .-2<CR>==gi",
  },
  normal_mode = {
    -- Moving with wrap on
    ["k"] = { "v:count == 0 ? 'gk' : 'k'", { expr = true } },
    ["j"] = { "v:count == 0 ? 'gj' : 'j'", { expr = true } },
    [";"] = ":",
    [":"] = ";",

    -- Buffer pane navigation
    ["<C-l>"] = "<C-w>l",
    ["<C-h>"] = "<C-w>h",
    ["<C-k>"] = "<C-w>k",
    ["<C-j>"] = "<C-w>j",

    ["<c-w>z"] = "<c-w>_",
    ["L"] = "g_",
    ["H"] = "^",
    ["zh"] = "zH", -- Moves left half screen
    ["zl"] = "zL", -- Moves right half screen

    -- Retains column positions while moving
    ["z<cr>"] = "zt", -- Moves the line to the top of the screen
    ["z."] = "zz", -- Moves the line to the middle of the screen
    ["z-"] = "zb", -- Moves the line to the bottom of the screen
    ["<c-u>"] = "<c-u>zz",
    ["<c-d>"] = "<c-d>zz",

    -- Centers the line on next search result
    ["n"] = "nzz",
    ["N"] = "Nzz",

    -- Paste
    ["]p"] = "o<Esc>p",
    ["]P"] = "O<Esc>p",

    -- Insert blank lines
    ["]<Space>"] = "o<Esc>",
    ["[<Space>"] = "O<Esc>",

    -- Move lines
    -- ["<A-j>"] = ":m .+1<CR>==",
    -- ["<A-k>"] = ":m .-2<CR>==",

    ["Y"] = "y$",
    ["<c-q>"] = ":call QuickFixToggle()<CR>",
    ["<UP>"] = "<c-w>3-",
    ["<DOWN>"] = "<c-w>3+",
    ["<LEFT>"] = "<c-w>3<",
    ["<RIGHT>"] = "<c-w>3>",
    ["gs"] = {
      "<Plug>(leap-cross-window)",
      { noremap = false, silent = false },
    },
    ["ga"] = {
      "<Plug>(EasyAlign)",
      { noremap = false, silent = false },
    },
  },
  visual_mode = {
    [";"] = ":",
    [":"] = ";",
    ["<leader>h"] = "<cmd>noh<CR>",
    ["L"] = "g_",
    ["H"] = "^",
    ["p"] = "pgvy",
    ["<"] = "<gv",
    [">"] = ">gv",
    -- Move lines
    ["<A-j>"] = ":m '>+1<CR>gv=gv",
    ["<A-k>"] = ":m '<-2<CR>gv=gv",
  },
  term_mode = {
    -- ['<C-w><C-o>'] = '<C-\\><C-n> :MaximizerToggle!<CR>',
    -- ['<C-h>'] = '<C-\\><C-n><C-w>h',
    -- ['<C-j>'] = '<C-\\><C-n><C-w>j',
    -- ['<C-k>'] = '<C-\\><C-n><C-w>k',
    -- ['<C-l>'] = '<C-\\><C-n><C-w>l',
    -- ['jk'] = '<C-\\><C-n>'
  },
  command_mode = {
    ["<C-j>"] = {
      'pumvisible() ? "\\<C-n>" : "\\<C-j>"',
      { expr = true, noremap = true },
    },
    ["<C-k>"] = {
      'pumvisible() ? "\\<C-p>" : "\\<C-k>"',
      { expr = true, noremap = true },
    },
  },
  visual_block_mode = {
    ["ga"] = {
      "<Plug>(EasyAlign)",
      { noremap = false, silent = false },
    },
    -- TODO: fix these mappings
    ["."] = {
      "<CMD>normal .<CR>",
      { noremap = true, silent = false },
    },
    ["@"] = {
      "<cmd><C-u>echo '@'.getcmdline() | execute ':'<,'>normal @' . nr2char(getchar())<Cr>'",
      { noremap = false, silent = true },
    },
  },
}

local lsp_keymappings = {

  normal_mode = {
    ["K"] = "<Cmd>lua vim.lsp.buf.hover()<CR>",
    ["gD"] = "<Cmd>lua vim.lsp.buf.declaration()<CR>",
    ["gd"] = "<Cmd>lua vim.lsp.buf.definition()<CR>",
    ["gI"] = "<Cmd>lua vim.lsp.buf.implementation()<CR>",
    ["gr"] = "<cmd>lua vim.lsp.buf.references()<CR>",
    ["<leader>k"] = "<Cmd>lua vim.lsp.buf.signature_help()<CR>",
    ["[d"] = "<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
    ["]d"] = "<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>",
    ["[e"] = "<Cmd>Lspsaga diagnostic_jump_next<CR>",
    ["]e"] = "<Cmd>Lspsaga diagnostic_jump_prev<CR>",
  },
}
-- Auto indent line when in an empty line
keymap("n", "i", function()
  if #vim.fn.getline "." == 0 then
    return [["_cc]]
  else
    return "i"
  end
end, { expr = true })

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
  for k, v in pairs(keymaps) do
    M.set_keymaps(mode, k, v)
  end
end

function M.setup()
  for mode, mapping in pairs(keymappings) do
    M.map(mode, mapping)
  end
end

function M.setup_lsp_mappings()
  for mode, mapping in pairs(lsp_keymappings) do
    M.map(mode, mapping)
  end
end

M.setup()

return M
