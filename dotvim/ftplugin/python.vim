setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
"setlocal textwidth=80
setlocal smarttab
setlocal expandtab
setlocal smartindent
setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
normal m`:%s/\s\+$//e ``

setlocal syntax=python
