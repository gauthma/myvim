" Notes: 
" - when running XeLaTeX (<F6> mapping), --shell-escape is needed to
"   allow it to invoke external programs, e.g. gnuplot when using Tikz to plot
"   functions
"
" - the cleaning map was changed from <Leader>c to <F4> because, for some
"   reason, leader in *.tex files yields no output... Also, the .gnuplot and
"   .table files are generated when using gnuplot as described above.
"
nnoremap <F4> :! cd "%:p:h" ; rm -f *.{dvi,ps,pdf,aux,log,out,toc,gnuplot,table,bbl,blg} ; echo "Clean up done" <CR>
nnoremap <F5> :! cd "%:p:h" ; bibtex "%:t"<CR>
nnoremap <F6> :! cd "%:p:h" ; xelatex --interaction=nonstopmode --shell-escape "%:t"<CR>
nnoremap <F7> :! okular --unique &> /dev/null %<.pdf &<CR>
nnoremap <silent> <F8> :call FullDocumentGeneration()<CR>

" insert new line below starting with a % (not indented)
nnoremap <Leader>o o<Esc>0i%<Esc>

inoremap <buffer> " <C-R>=<SID>TexQuotes()<CR>

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

" TODO eventually figure out a way of avoiding that after calling this
" function (which gets executed in the shell), the control flow get
" automatically to vim (no "press enter to continue", as per usual shell
" commands ran with :! )
function! FullDocumentGeneration()
	execute "normal \<F6>"
	execute "normal \<F5>"
	execute "normal \<F6>"
	execute "normal \<F6>"
endfunction

