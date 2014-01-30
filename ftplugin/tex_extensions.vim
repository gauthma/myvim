" Custom extensions for (and automagically sourced by) TeX-9

" TeX-9 missing emph mapping
inoremap <C-e> \emph{

" ... as well as varepsilon
inoremap <buffer> <LocalLeader>e \varepsilon

" insert new line below starting with a % (not indented)
nnoremap <Leader>o o<Esc>0i%<Esc>

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

" Mapping for LaTeX, Kyle-style: F5 - BiBTeX, F6 -> compile, F7 -> view in
" okular, F8 -> full compile, F9 -> clean aux files
" Notes: 
" - Vim must ALWAYS be launched from the folder where the Makefile (and the
"   main *.tex file) are located -- otherwise the shortcuts b0rk, for obvious
"   reasons (they won't be able to find the Makefile)
" - when running LuaTeX (<F6> mapping), --shell-escape is needed to
"   allow it to invoke external programs, e.g. gnuplot when using Tikz to plot
"   functions
"
nnoremap <F5> :execute '! make bib'<CR>
nnoremap <F6> <Esc>:w<CR>: execute '! make all'<CR>
nnoremap <silent> <F7> :execute '! make viewer'<CR>
nnoremap <silent> <F8> :execute '! make full'<CR>
nnoremap <F9> :execute '! make clean'<CR>

"nunmap <F2> " I use this for NERDTree
noremap <F2> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
