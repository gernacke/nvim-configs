local M = {}

local function augroup(name)
  return vim.api.nvim_create_augroup("mnv_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ "Filetype" }, {
  pattern = {
    "Jaq",
    "qf",
    "man",
    "lspinfo",
    "spectre_panel",
    "lir",
    "DressingSelect",
    "tsplayground",
  },
  callback = function()
    vim.cmd([[
        nnoremap <silent> <buffer> q :close<CR> 
        nnoremap <silent> <buffer> <esc> :close<CR> 
        set nobuflisted 
    ]])
  end,
})

-- General form of the atuocmd function
-- vim.api.nvim_create_autocmd("BufReadPost,BufNewFile","*.md", {
--   "setlocal wrap=false"
-- })

-- autocmd Filetype markdown IndentLinesDisable
-- Set conceal level when in markdown file for zk notes
-- vim.api.nvim_create_autocmd({ "Filetype" }, {
--   pattern = { "Markdown" },
--   callback = function()
--     vim.opt_local.conceallevel = 2
--     vim.opt_local.wrap = true
--     vim.opt_local.spell = true
--     -- vim.keymap.del("n", "<CR>", { buffer = true })
--     -- vim.api.nvim_set_keymap("n", "<CR>", ":Lspsaga goto_definition<CR>", { noremap = true, silent = true })
--     vim.cmd [[ syn match markdownIgnore "\w\@<=\w\@=" ]]
--   end,

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "gitcommit" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.wrap = true
    vim.cmd([[ syn match markdownIgnore "\w\@<=\w\@=" ]])
    vim.opt_local.conceallevel = 2
    vim.opt_local.linebreak = true -- prevents breaking words
    vim.b.snacks_indent = false -- prevents indent lines from folke/snacks
  end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  pattern = { "" },
  callback = function()
    vim.cmd([[ set formatoptions-=cro ]])
  end,
})

-- Set .keymap files to c filetype
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.keymap" },
  callback = function()
    vim.bo.filetype = "c"
  end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  pattern = { "" },
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 150 })
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "" },
  callback = function()
    local get_project_dir = function()
      local cwd = vim.fn.getcwd()
      local project_dir = vim.split(cwd, "/")
      local project_name = project_dir[#project_dir]
      return project_name
    end

    vim.opt.titlestring = get_project_dir() .. " - nvim"
  end,
})

-- Go to last loction when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Auto-command to customize chat buffer behavior
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "copilot-*",
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})
-- show cursor line only in active window
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  callback = function()
    local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
    if ok and cl then
      vim.wo.cursorline = true
      vim.api.nvim_win_del_var(0, "auto-cursorline")
    end
  end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  callback = function()
    local cl = vim.wo.cursorline
    if cl then
      vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
      vim.wo.cursorline = false
    end
  end,
})
-- Auto format on buffer write
-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
-- 	pattern = { "" },
-- 	callback = function()
-- 		vim.lsp.buf.format({ async = true })
-- 	end,
-- })

vim.cmd([[
augroup nvim-incsearch-cursorline
	autocmd!
	autocmd CmdlineEnter /,\? :set cursorline hlsearch
augroup END
]])

vim.cmd([[

" highlight yanked text for 200ms using the "Visual" highlight group
  " augroup highlight_yank
  "   autocmd!
  "   au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=150})
  " augroup END


  " augroup _general_settings
  "   autocmd!
  "   autocmd Filetype qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
  "   autocmd BufWinEnter * :set formatoptions-=cro
  "   autocmd Filetype qf set nobuflisted
  " augroup end

  " augroup _git
  "   autocmd!
  "   autocmd Filetype gitcommit setlocal wrap
  "   autocmd Filetype gitcommit setlocal spell
  " augroup end

  " augroup _auto_resize
  "   autocmd!
  "   autocmd VimResized * tabdo wincmd =
  " augroup end
]])

-- vim.api.nvim_create_autocmd("ColorScheme", {
--   group = vim.api.nvim_create_augroup("MyHighlights", { clear = true }),
--   callback = function()
--     vim.cmd([[ highlight VertSplit guifg=#665c54 guibg=NONE ]])
--   end,
-- })

-- Delete the <CR> mapping (clear incremental_selection in treesitter configs)
-- vim.api.nvim_create_autocmd("CmdwinEnter *", {
--   group = vim.api.nvim_create_augroup("CmdwinOpen", { clear = true }),
--   callback = function()
--     vim.keymap.del("n", "<CR>", { buffer = true })
--   end,
-- })
-- Enter `TermMode` and start `Insert` mode automatically
-- vim.api.nvim_create_autocmd("TermOpen", {
--   group = vim.api.nvim_create_augroup("TerminalOpen", { clear = true }),
--   callback = function()
--     vim.cmd([[ startinsert ]])
--     vim.wo.number = false
--     vim.wo.relativenumber = false
--   end,
-- })

-- vim.api.nvim_create_autocmd("TermLeave", {
--   group = vim.api.nvim_create_augroup("TerminalLeave", { clear = true }),
--   callback = function()
--     vim.wo.number = true
--     vim.wo.relativenumber = true
--   end,
-- })

-- Define a Lua function to center the cursor ignoring scrolloff
-- function CenterCursorWithoutScrolloff()
--   -- Save the current value of 'scrolloff'
--   local old_scrolloff = vim.o.scrolloff
--   -- Set 'scrolloff' to zero
--   vim.o.scrolloff = 0
--   -- Execute 'zz' to center the cursor
--   vim.cmd("normal! zz")
--   -- Restore the original value of 'scrolloff'
--   vim.o.scrolloff = old_scrolloff
-- end

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Change cursor to underline when entering terminal
vim.api.nvim_set_hl(0, "TerminalCursorShape", { underdouble = true })
vim.api.nvim_create_autocmd("TermEnter", {
  callback = function()
    vim.cmd([[setlocal winhighlight=TermCursor:TerminalCursorShape]])
  end,
})

-- Change cursor back to vertical bar when leaving vim
vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    vim.cmd([[set guicursor=a:ver25]])
  end,
})

-- vim.api.nvim_create_autocmd("VimEnter", {
--   group = vim.api.nvim_create_augroup("illuminate_augroup", { clear = true }),
--   callback = function()
--     vim.cmd "hi illuminatedCurWord cterm=italic gui=italic"
--   end,
-- })

-- vim.cmd [[
-- augroup illuminate_augroup
--     autocmd!
--     autocmd VimEnter * hi illuminatedCurWord cterm=italic gui=italic
-- augroup END
-- ]]

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
  pattern = "NvimTree_*",
  callback = function()
    local layout = vim.api.nvim_call_function("winlayout", {})
    if
      layout[1] == "leaf"
      and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree"
      and layout[3] == nil
    then
      vim.cmd("confirm quit")
    end
  end,
})

-- Toggles the color column at 80
function M.toggle_color_column()
  if vim.wo.colorcolumn == "" then
    vim.wo.colorcolumn = "80"
  else
    vim.wo.colorcolumn = ""
  end
end

function M.toggle_text_wrap()
  if vim.wo.wrap then
    vim.wo.wrap = false
  else
    vim.wo.wrap = true
  end
end

-- toggle search crosshairs
function M.toggle_crosshairs()
  local current_win = vim.api.nvim_get_current_win()
  vim.api.nvim_set_option("hlsearch", not vim.api.nvim_get_option("hlsearch"))
  vim.cmd([[windo :lua vim.api.nvim_win_set_option(0, 'cursorline', vim.api.nvim_get_option 'hlsearch')
]])
  -- vim.cmd([[windo :lua vim.api.nvim_win_set_option(0, 'cursorcolumn', vim.api.nvim_get_option 'hlsearch') ]])
  vim.api.nvim_set_current_win(current_win)
end

function M.link_illuminate_hlgroup()
  vim.api.nvim_create_autocmd({ "ColorScheme" }, {
    callback = function()
      vim.cmd("hi link illuminatedWord LspReferenceText")
    end,
  })
end

-- function M.enable_transparent_mode()
--   vim.api.nvim_create_autocmd("ColorScheme", {
--     pattern = "*",
--     callback = function()
--       local hl_groups = {
--         "Normal",
--         "WinbarNC",
--         "SignColumn",
--         "NormalNC",
--         "TelescopeBorder",
--         "NvimTreeNormal",
--         "EndOfBuffer",
--         "MsgArea",
--       }
--       for _, name in ipairs(hl_groups) do
--         vim.cmd(string.format("highlight %s ctermbg=none guibg=none", name))
--       end
--     end,
--   })
--   vim.opt.fillchars = "eob: "
-- end

-- M.enable_transparent_mode()
M.link_illuminate_hlgroup()

-- Create mappings to modify target window via split
local map_split = function(buf_id, lhs, direction)
  local rhs = function()
    -- Make new window and set it as target
    local new_target_window
    vim.api.nvim_win_call(MiniFiles.get_target_window(), function()
      vim.cmd(direction .. " split")
      new_target_window = vim.api.nvim_get_current_win()
    end)

    MiniFiles.set_target_window(new_target_window)
  end

  -- Adding `desc` will result into `show_help` entries
  local desc = "Split " .. direction
  vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
end

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  callback = function(args)
    local buf_id = args.data.buf_id
    -- Tweak keys to your liking
    map_split(buf_id, "gs", "belowright horizontal")
    map_split(buf_id, "gv", "belowright vertical")
  end,
})

-- Neovim 0.11 made `position_encoding` required in make_position_params and
-- warns when it's omitted. Several plugins (lspsaga, vim-illuminate, trouble,
-- telescope, inc-rename) still call it without one. Shim it to default to the
-- buffer's first client encoding so the warning doesn't fire on every call.
vim.lsp.util.make_position_params = (function(original)
  return function(window, offset_encoding)
    window = window or 0
    if not offset_encoding then
      local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_win_get_buf(window) })
      offset_encoding = clients[1] and clients[1].offset_encoding or "utf-16"
    end
    return original(window, offset_encoding)
  end
end)(vim.lsp.util.make_position_params)

return M
