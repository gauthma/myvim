setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal textwidth=80
setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class
normal m`:%s/\s\+$//e ``

setlocal syntax=python

set nonu

source $HOME/.vim/customizations/ExpandFoldsOnOpenFile.vim
