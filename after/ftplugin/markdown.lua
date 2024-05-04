require("cmp").setup.buffer({
  sources = {
    { name = "buffer" },
    {
      name = "look",
      keyword_length = 2,
      options = {
        convert_case = true,
        loud = true,
      },
    },
    { name = "path" },
    { name = "emoji" },
  },
})

vim.cmd([[
  highlight @markup.heading.1.markdown guifg=#A45EE5 gui=bold
  highlight @markup.heading.2.markdown guifg=#FF6E67 gui=bold
  highlight @markup.heading.3.markdown guifg=#06D6A0 gui=bold
  highlight @markup.heading.4.markdown guifg=#8be9fd gui=bold
  highlight @markup.heading.5.markdown guifg=#FFD166 gui=bold
  highlight @lsp.type.class.markdown ctermfg=72 guifg=#689d6a cterm=bold,underline gui=bold,underline

  hi tklink ctermfg=72 guifg=#689d6a cterm=bold,underline gui=bold,underline
  hi tkBrackets ctermfg=gray guifg=gray
  hi tkHighlight ctermbg=214 ctermfg=124 cterm=bold guibg=#fabd2f guifg=#9d0006 gui=bold
  hi tkTag ctermfg=175 guifg=#fabd2f
  hi tkTagSep ctermfg=gray guifg=gray
  hi link CalNavi CalRuler
  syntax region @text.reference.markdown_inline start=/|/ end=/$/ contained
]])
