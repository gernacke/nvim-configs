nnoremap <silent> <leader>; :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <silent> <leader>; :<c-u>call <SID>GrepOperator(visualmode())<cr>

function! s:GrepOperator(type)
    " saving the current register
    let saved_unamed_register = @@

    " if in characterwise visual mode
    if a:type ==# 'v'
        normal! `<v`>y
    " if in a characterwise motion with the operator, e.g. <map>iw
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif

    " Grep the selected word recursively in current folder
    silent execute "grep! -R " . shellescape(@@) . " ."
    copen

    " return the previous register
    let @@ = saved_unamed_register
endfunction
