local opt = vim.opt
local cmd = vim.cmd
local indent = 2

local options = {
  syntax = "enabled",
  cursorline = true,
  wrap = false,
  swapfile = false,
  termguicolors = true,
  autoindent = true, -- Copy indent from current line when starting a new line
  smartindent = true, -- Do smart autoindenting when starting a new line.
  modeline = true, -- If 'modeline' is on 'modelines' gives the number of lines that is checked for set commands.
  modelines = 2,
  expandtab = true, -- In Insert mode: Use the appropriate number of spaces to insert a <Tab>
  shiftwidth = indent, -- Number of spaces to use for each step of (auto)indent.
  softtabstop = 4, -- Number of spaces that a <Tab> counts for while performing editing operations, like inserting a <Tab> or using <BS>.
  tabstop = indent, -- Number of spaces that a <Tab> in the file counts for.
  shiftround = true, -- Round indent to multiple of 'shiftwidth'.
  smarttab = true, -- When on, a <Tab> in front of a line inserts blanks according to 'shiftwidth'.
  synmaxcol = 240, -- Maximum column in which to search for syntax items.
  textwidth = 0, -- Maximum width of text that is being inserted. A longer line will be broken after white space to get this width. A zero value disables this.
  signcolumn = "yes", -- Always show the gutter sign column
  undofile = true, -- When on, Vim automatically saves undo history to an undo file when writing a buffer to a file, and restores undo history from the same file on buffer read.
  autoread = true, -- When a file has been detected to have been changed outside of Vim and it has not been changed inside of Vim, automatically read it again.
  backspace = "indent,eol,start", -- Influences the working of <BS>, <Del>, CTRL-W and CTRL-U in Insert mode.
  clipboard = "unnamed,unnamedplus", -- A variant of the "unnamed" flag which uses the clipboard register '+' (|quoteplus|) instead of register '*' for all yank, delete, change and put operations which would normally go to the unnamed register.
  laststatus = 3, -- The value of this option influences when the last window will have a status line
  encoding = "utf-8",
  guifont = "FiraCode Nerd Font:h20",
  hidden = true, -- When off a buffer is unloaded (including loss of undo information) when it is abandoned. When on a buffer becomes hidden when it is abandoned.
  inccommand = "split", -- When nonempty, shows the effects of |:substitute|, |:smagic|, |:snomagic|
  incsearch = true,
  lazyredraw = false, -- When this option is set, the screen will not be redrawn while executing macros, registers and other commands that have not been typed.
  -- listchars = "tab:⍿·,trail:-,extends:>,precedes:<,nbsp:+,eol:↴",
  -- The character to show after the special character in the list.

  mouse = "nv", -- Enables mouse support. For example, to enable the mouse in Normal mode and Visual mode.
  ruler = true, -- Show the line and column number of the cursor position, separated by a comma.
  sessionoptions = {
    "blank",
    "buffers",
    "curdir",
    "folds",
    "help",
    "tabpages",
    "winsize",
    "resize",
    "winpos",
    "terminal",
  },
  showmatch = true, -- When a bracket is inserted, briefly jump to the matching one.
  showtabline = 0, -- never show the tab line at the top of the buffers
  matchtime = 1, -- Tenths of a second to show the matching paren, when 'showmatch' is set.
  showmode = false, -- If in Insert, Replace or Visual mode put a message on the last line.
  sidescrolloff = 5, -- The minimal number of screen columns to keep to the left and to the right of the cursor if 'nowrap' is set.
  scrolloff = 2,
  ignorecase = true, -- Ignore case in search patterns.
  smartcase = true, -- Override the 'ignorecase' option if the search pattern contains upper case characters.
  splitkeep = "screen",
  splitbelow = true,
  splitright = true,
  timeoutlen = 500, -- Time in milliseconds to wait for a mapped sequence to complete.
  updatetime = 300, -- If this many milliseconds nothing is typed the swap file will be written to disk (see |crash-recovery|).
  wildmode = "longest:full", -- Completion mode that is used for the character specified with 'wildchar'.
  breakindent = true, -- Every wrapped line will continue visually indented (same amount of space as the beginning of that line), thus preserving horizontal blocks of text.
  list = true, -- List mode: By default, show tabs as ">", trailing spaces as "-", and non-breakable space characters as "+".
  number = true, -- Print the line number in front of each line.
  relativenumber = true,
  pumblend = 17, -- Enables pseudo-transparency for the |popup-menu|.
  pumheight = 10, -- Maximum height of the |popup-menu|.
  title = true,
}

vim.g.mapleader = " "

for k, v in pairs(options) do
  vim.opt[k] = v
end

opt.iskeyword:append("-") -- treats abcd-edfd as one single word in motion
opt.runtimepath:prepend("~/.vim")
opt.runtimepath:append("~/.vim/after")
opt.display:append("lastline")
opt.nrformats:remove("octal")
opt.viewoptions:remove("options")
opt.listchars = opt.listchars + "trail:-" + "extends:>" + "precedes:<" + "nbsp:+"
-- + "eol:↴"
-- + "tab:⍿·"
opt.formatoptions = opt.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  - "r" -- Don't insert comment after <Enter>
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- I'm not in gradeschool anymore

cmd([[
let g:db_ui_use_nerd_fonts = 1
let g:db_ui_icons = {
		\ 'expanded': {
		\   'db': '▾ ',
		\   'buffers': '▾ ',
		\   'saved_queries': '▾ ',
		\   'schemas': '▾ ',
		\   'schema': '▾ פּ',
		\   'tables': '▾ 藺',
		\   'table': '▾ ',
		\ },
		\ 'collapsed': {
		\   'db': '▸ ',
		\   'buffers': '▸ ',
		\   'saved_queries': '▸ ',
		\   'schemas': '▸ ',
		\   'schema': '▸ פּ',
		\   'tables': '▸ 藺',
		\   'table': '▸ ',
		\ },
		\ 'saved_query': '',
		\ 'new_query': '璘',
		\ 'tables': '離',
		\ 'buffers': '﬘',
		\ 'add_connection': '',
		\ 'connection_ok': '✓',
		\ 'connection_error': '✕',
	\ }

]])
-- cmd [[
--     augroup spell
--       " Remove all spell autocommands
--       autocmd!
--       au BufEnter *.md,*.norg set spell
--     augroup END
-- ]]

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.cmd.highlight("default link IndentLine Comment")

-- Remove deprecated commands from Neotree
-- vim.g.neo_tree_remove_legacy_commands = 1

-- opt.shortmess = opt.shortmess
--     + "W"
--     + "c"
