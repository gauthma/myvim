nmap <F6> :! cd "%:p:h" ; xelatex --interaction=nonstopmode "%:t"<CR>
nmap <F7> :! okular --unique &> /dev/null %<.pdf &<CR>
inoremap <buffer> " <C-R>=<SID>TexQuotes()<CR>

nmap <Leader>c :! cd "%:p:h" ; find . \( -iname "*.log" -o -iname "*.aux" -o -iname "*.bbl" -o -iname "*.out" -o -iname "*.xdv" -o -iname "*.brf" -o -iname "*.blg" -o -iname "*.dvi" \) -exec rm -f {} +<CR>

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
