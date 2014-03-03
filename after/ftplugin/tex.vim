" TeX-9 "helpfully" changes this...
set softtabstop =2
set tabstop     =2
set shiftwidth  =2

" ... and this
nnoremap <buffer> <F2> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
nnoremap <buffer> <F4> :GundoToggle<CR><CR>

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

" I like \varepsilon better
inoremap <buffer> <LocalLeader>e \varepsilon
