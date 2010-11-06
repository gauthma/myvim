" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
set sw=2
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:

" shortcuts from Kile: Alt+6 to compile to pdf, Alt+7 to open pdf with oKular
" NOTE: for information about the Alt key behaviour in vim, see:
" http://vim.wikia.com/wiki/Get_Alt_key_to_work_in_terminal
set <A-6>=6
set <A-7>=7
map <A-6> <Esc>\ll
map <A-7> <Esc>\lv

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
""let g:Tex_CompileRule_dvi='xelatex --interaction=nonstopmode $*'
let g:Tex_CompileRule_pdf='xelatex -interaction=nonstopmode $*'
let g:Tex_ViewRule_pdf='okular &> /dev/null'

let g:Tex_MultipleCompileFormats='pdf'
