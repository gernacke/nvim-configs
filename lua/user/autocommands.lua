local M = {}

vim.cmd([[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
  augroup end

  augroup _neorg
    autocmd!
    autocmd FileType norg setlocal wrap
    autocmd FileType norg setlocal spell
  augroup end

  " augroup _auto_resize
  "   autocmd!
  "   autocmd VimResized * tabdo wincmd =
  " augroup end

  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end

" highlight yanked text for 200ms using the "Visual" highlight group
  augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=150})
  augroup END

  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]])

function M.enable_transparent_mode()
	vim.api.nvim_create_autocmd("ColorScheme", {
		pattern = "*",
		callback = function()
			local hl_groups = {
				"Normal",
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
-- Autoformat
-- augroup _lsp
--   autocmd!
--   autocmd BufWritePre * lua vim.lsp.buf.formatting()
-- augroup end
