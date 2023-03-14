local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    ["<space>"] = "SPC",
    ["<cr>"] = "RET",
    ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
  },
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local vopts = {
  mode = "v", -- VISUAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  ["<tab>"] = {
    "<cmd>lua require('user.configs.telescope_config').switch_buffers()<cr>",
    "Switch Buffers",
  },
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  ["q"] = { "<cmd>q!<CR>", "Quit" },
  ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  ["h"] = { "<CMD>lua require('user.autocommands').toggle_crosshairs()<CR>", "Toggle Crosshairs" },
  ["f"] = {
    "<cmd>lua require('user.configs.telescope_config').project_files()<cr>",
    "Find Files",
  },
  ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
  ["P"] = {
    "<cmd>lua require('telescope').extensions.projects.projects()<cr>",
    "Projects",
  },

  p = {
    name = "+Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },

  g = {
    name = "+Git",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = {
      "<cmd>lua require('user.configs.telescope_config').git_branches()<cr>",
      "Checkout branch",
    },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    D = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff" },
    d = { "<cmd>lua require'gitsigns'.toggle_deleted()<cr>", "Toggle Deleted Lines" },
  },

  l = {
    name = "+LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Document Diagnostics" },
    e = { "<cmd>NvimTreeFocus<cr>", "Focus Explorer" },
    w = { "<cmd>Telescope diagnostics<cr>", "Workspace Diagnostics" },
    f = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format" },
    F = { "<cmd>LspToggleAutoFormat<cr>", "Toggle Autoformat" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    j = { "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "Next Diagnostic" },
    k = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
    v = { "<cmd>lua require('lsp_lines').toggle()<cr>", "Virtual Text" },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    s = { "<cmd>lua require('user.configs.telescope_config').document_symbols()<cr>", "Document Symbols" },
    -- S = { "<cmd>lua require('user.configs.telescope_config').workspace_symbols()<cr>", "Workspace Symbols", },
  },
  n = {
    name = "+Neorg",
    n = { "<CMD>NeorgStart<CR>", "Load Neorg" },
    w = {
      "<CMD>Neorg workspace neorg<CR>",
      "Default Neorg workspace (Neorg/)",
    },
    r = { "<CMD>Neorg return<CR>", "Neorg return prev place" },
    t = { "<CMD>Neorg toc toqflist<CR>", "Add ToC to quickfix list" },
    f = { "<CMD>Telescope neorg insert_file_link<CR>", "Insert a file link" },
    l = { "<CMD>Telescope neorg insert_link<CR>", "Insert a link" },
    c = { "<CMD>Neorg gtd capture<CR>", "Capture a task" },
    v = { "<CMD>Neorg gtd views<CR>", "View GTDs" },
    e = { "<CMD>Neorg gtd edit<CR>", "Edit Tasks" },
    s = { "<CMD>Neorg sync-parsers<CR>", "Sync Parsers" },
  },
  o = {
    name = "+Neovim",
    f = {
      "<cmd>lua require('user.configs.telescope_config').search_dotfiles()<cr>",
      "Find Dotfiles",
    },
    g = {
      "<cmd>lua require('user.configs.telescope_config').grep_dotfiles()<cr>",
      "Grep Dotfiles",
    },
    n = {
      "<cmd>lua require('user.configs.telescope_config').search_neorgfiles()<cr>",
      "Search Neorg Files",
    },
    h = {
      "<cmd>edit ~/repositories/workbench/help.md<cr>",
      "Open Help.md",
    },
    N = {
      "<cmd>lua require('user.configs.telescope_config').search_neorg()<cr>",
      "Grep Neorg",
    },
    o = {
      "<cmd>lua require('user.configs.telescope_config').search_notefiles()<cr>",
      "Search Note Files",
    },
    O = {
      "<cmd>lua require('user.configs.telescope_config').search_notes()<cr>",
      "Grep Notes",
    },
    b = {
      "<cmd>lua require('user.configs.telescope_config').browse_nvim_configs()<cr>",
      "File Browser Neorg",
    },
    t = {
      "<cmd>lua require('user.configs.telescope_config').grep_prompt()<cr>",
      "Search Neorg Files",
    },
  },
  s = {
    name = "+Search",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    C = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    m = {
      "<cmd>lua require('user.configs.telescope_config').firefox_bookmarks()<cr>",
      "Firefox Bookmarks",
    },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    l = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    p = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    c = { "<cmd>Telescope commands<cr>", "Commands" },
    f = {
      "<cmd>lua require('user.configs.telescope_config').file_browser()<cr>",
      "Open File Browser",
    },
  },
  t = {
    name = "+Terminal",
    u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
    t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
  },
  b = {
    name = "+Trouble",
    d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
    l = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
    w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
    s = { "<cmd>SymbolsOutline<cr>", "Symbols Outline" },
  },
  v = {
    name = "+Tmux runner",
    p = { "<CMD>VtrAttachToPane<CR>", "Attach to pane" },
    l = { "<CMD>VtrSendLinesToRunner<CR>", "Send line to runner" },
    o = {
      "<CMD>VtrOpenRunner {'orientation': 'h', 'percentage': 50}<CR>",
      "Open runner",
    },
    y = { "<cmd>%yank<CR>", "Yank page" },
    d = { "<Cmd>%d<Cr>", "Delete buffer content" },
  },
  w = {
    name = "+Window Resize",
    h = { "<CMD>wincmd |<CR>", "Maximize Window Horizontally" },
    v = { "<CMD>wincmd _<CR>", "Maximize Window Vertically" },
    o = { "<CMD>wincmd =<CR>", "Reset Window Size" },
  },
  z = {
    name = "+ZK",
    n = { "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", "New ZK Note" },
    c = { "<CMDZkCd<CR>", "CD into ZK Directory" },
    o = { "<CMD>ZkNotes { sort = { 'modified' } }<CR>", "Open ZK Notes" },
  },
}

local vmappings = {
  s = {
    name = "+Search",
    -- i = {
    -- 	"<cmd>call OpenSearch('Google',GetVisualSelection())<cr>",
    -- 	"Search Online",
    -- },
  },
}

which_key.setup(setup)
which_key.register(mappings, opts)
-- which_key.register(vmappings, vopts)
