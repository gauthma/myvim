" TeX-9 "helpfully" changes some of this... so dump it all inside after
set softtabstop =2
set tabstop     =2
set shiftwidth  =2

set wrap
set linebreak
set nolist
set autoindent
set fo+=t
set fo+=l
set fo-=n               " TeX can handle its own numbered lists...
set fo+=w
set tw=80

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
" XXX see why this required at all...
inoremap <buffer> :e \varepsilon

" for angle brackets
inoremap :« \langle
inoremap :» \rangle
