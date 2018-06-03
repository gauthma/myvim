function! SetupEmailText()
  " Reformat quoted lines (if any)...
  :g/^>/. normal gqgq
  "... and make sure that not empty lines (*excluding* lines with only >>>, as
  "these count as empty) end with a space (for format_flow).
  :%s/^.\+\ze\n\(>*$\)\@!/\0 /e
  " Finally take the lines that only have >>>, and make sure they do *not* 
  " end with a space (for the same reason).
  :%s/^>*\zs\s\+$//e

  " Make sure that the file is always presented to the user with (at least)
  " two empty lines at the start (adding them if necessary).
  :1
  if strlen(getline(1)) == 0
    if strlen(getline(2)) != 0
      " We get here if the first line is empty, but not the second. Hence, add
      " one empty line.
      :put! =\"\n\"
    " else the first two lines are empty, hence we do nothing.
    endif
  else
    " Here we get when the first line is nonempty -- hence we add two empty
    " ones.
    :put! =\"\n\n\"
  endif
  :1
endfunction

augroup mail_filetype
  autocmd!
  autocmd VimEnter ~/.mutt/tmp/mutt* :call SetupEmailText()
  autocmd VimEnter ~/.mutt/tmp/mutt* :exe 'startinsert'
augroup END

setl tw=72
setl fo+=w
setl fo-=a

setlocal foldcolumn=1

" justify paragraph, from current line onwards
nnoremap Q mqgq}`q

" Have to undo the Escape map (see vimrc), otherwise
" startinsert b0rks.
iunmap <Esc>
