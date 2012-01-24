"wrap 80 char lines
au BufEnter *.pdc call WriteTextMode()
au WinEnter *.pdc call WriteTextMode()
au BufEnter *.rst call WriteTextMode()
au WinEnter *.rst call WriteTextMode()
