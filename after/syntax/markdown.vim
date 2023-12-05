" markdownWikiLink is a new region
" syn region markdownWikiLink matchgroup=markdownLinkDelimiter start="\[\[" end="\]\]" contains=markdownUrl keepend oneline concealends
" markdownLinkText is copied from runtime files with 'concealends' appended
" syn region markdownLinkText matchgroup=markdownLinkTextDelimiter start="!\=\[\%(\%(\_[^][]\|\[\_[^][]*\]\)*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" nextgroup=markdownLink,markdownId skipwhite contains=@markdownInline,markdownLineStart concealends
" markdownLink is copied from runtime files with 'conceal' appended
" syn region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" contains=markdownUrl keepend contained conceal

" hi tklink ctermfg=72 guifg=#689d6a cterm=bold,underline gui=bold,underline
" hi tkBrackets ctermfg=gray guifg=gray
"
highlight @text.title.1.markdown guifg=#50fa7b gui=bold
highlight @text.title.2.markdown guifg=#1560BD gui=bold
highlight @text.title.3.markdown guifg=#A45EE5 gui=bold
highlight @text.title.4.markdown guifg=#8be9fd gui=bold
highlight @text.title.5.markdown guifg=#f1fa8c gui=bold
highlight @text.reference.markdown_inline ctermfg=72 guifg=#689d6a cterm=bold,underline gui=bold,underline



" syntax region @text.reference.markdown_inline start=/|/ end=/$/ contained
" [[Meditation_ropkkv|Meditation]]
" tkBrackets, tkBrackets, tkLink, tkAliasedLink | tkLink tkBrackets
" @punctuation.bracket.markdown_inline, @text.reference.markdown_inline
