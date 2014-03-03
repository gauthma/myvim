" Custom extensions for (and automagically sourced by) TeX-9

" insert new line below starting with a % (not indented)
nnoremap <Leader>o o<Esc>0i%<Esc>

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
