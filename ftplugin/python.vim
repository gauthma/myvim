set wrap " python-mode disables this...
"
" ### Bundle python-mode ##
" Disable pylint checking every save
"let g:pymode_lint_write = 0

" Disable python code folding
let g:pymode_folding = 1

autocmd Syntax python normal zR
"let g:pymode = 0

