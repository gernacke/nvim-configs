local M = {}

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = {
		"Jaq",
		"qf",
		"help",
		"man",
		"lspinfo",
		"spectre_panel",
		"lir",
		"DressingSelect",
		"tsplayground",
		"Markdown",
	},
	callback = function()
		vim.cmd([[
        nnoremap <silent> <buffer> q :close<CR> 
        nnoremap <silent> <buffer> <esc> :close<CR> 
        set nobuflisted 
    ]])
	end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	pattern = { "" },
	callback = function()
		vim.cmd([[ set formatoptions-=cro ]])
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "qf" },
	callback = function()
		vim.cmd([[ set nobuflisted ]])
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown", "norg" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
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

-- Auto format on buffer write
-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
-- 	pattern = { "" },
-- 	callback = function()
-- 		vim.lsp.buf.format({ async = true })
-- 	end,
-- })

vim.cmd([[

" highlight yanked text for 200ms using the "Visual" highlight group
  " augroup highlight_yank
  "   autocmd!
  "   au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=150})
  " augroup END

  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction

  " augroup _general_settings
  "   autocmd!
  "   autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
  "   autocmd BufWinEnter * :set formatoptions-=cro
  "   autocmd FileType qf set nobuflisted
  " augroup end

  " augroup _git
  "   autocmd!
  "   autocmd FileType gitcommit setlocal wrap
  "   autocmd FileType gitcommit setlocal spell
  " augroup end

  " augroup _markdown
  "   autocmd!
  "   autocmd FileType markdown setlocal wrap
  "   autocmd FileType markdown setlocal spell
  " augroup end

  " augroup _auto_resize
  "   autocmd!
  "   autocmd VimResized * tabdo wincmd =
  " augroup end
]])

vim.api.nvim_create_autocmd("BufEnter", {
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

function M.link_illuminate_hlgroup()
	vim.api.nvim_create_autocmd({ "VimEnter" }, {
		callback = function()
			vim.cmd("hi link illuminatedWord LspReferenceText")
		end,
	})
end

function M.enable_transparent_mode()
	vim.api.nvim_create_autocmd("ColorScheme", {
		pattern = "*",
		callback = function()
			local hl_groups = {
				"Normal",
				"WinbarNC",
				"SignColumn",
				"NormalNC",
				"TelescopeBorder",
				"NvimTreeNormal",
				"EndOfBuffer",
				"MsgArea",
			}
			for _, name in ipairs(hl_groups) do
				vim.cmd(string.format("highlight %s ctermbg=none guibg=none", name))
			end
		end,
	})
	vim.opt.fillchars = "eob: "
end

M.enable_transparent_mode()
M.link_illuminate_hlgroup()
