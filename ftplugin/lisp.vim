" slimv
" change path acordingly (or comment if unused)
let g:slimv_swank_cmd = '! xterm -e sbcl --load ~/.vim/bundle/slimv/slime/start-swank.lisp &'
setlocal commentstring=;%s  " for vim-commentary to function with .lisp files

let g:slimv_leader=','
let g:lisp_rainbow=1

let g:slimv_clhs_root="~/tmp/HyperSpec-7-0/HyperSpec/Body/"
let g:slimv_browser_cmd="firefox"

" from here: http://cliki.net/vim
" setlocal lisp autoindent showmatch cpoptions-=mp

" Possible folding method
" setlocal foldmethod=marker foldmarker=(,) foldminlines=1

" normal zR
