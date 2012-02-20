nmap <F6> :! xelatex --interaction=nonstopmode %<CR>
nmap <F7> :! okular --unique &> /dev/null %<.pdf &<CR>

" for LaTeX quotes
" from auctex: https://github.com/vim-scripts/auctex.vim
function! s:TexQuotes()
    let insert = "''"
    let left = getline('.')[col('.')-2]
    if left =~ '^\(\|\s\)$'
let insert = '``'
    elseif left == '\'
let insert = '"'
    endif
    return insert
endfunction
inoremap <buffer> " <C-R>=<SID>TexQuotes()<CR>
