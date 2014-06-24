" Reformat lines (getting the spacing correct) {{{
fun! TeX_fmt()
	if (getline(".") != "")
		let save_cursor = getpos(".")
		let op_wrapscan = &wrapscan
		set nowrapscan
		let par_begin = '^\(%D\)\=\s*\($\|\\label\|\\begin\|\\end\|\\[\|\\]\|\\\(sub\)*section\>\|\\item\>\|\\NC\>\|\\blank\>\|\\noindent\>\)'
		let par_end   = '^\(%D\)\=\s*\($\|\\begin\|\\end\|\\[\|\\]\|\\place\|\\\(sub\)*section\>\|\\item\>\|\\NC\>\|\\blank\>\)'
		try
			exe '?'.par_begin.'?+'
		catch /E384/
			1
		endtry
		norm V
		try
			exe '/'.par_end.'/-'
		catch /E385/
			$
		endtry
		norm gq
		let &wrapscan = op_wrapscan
		call setpos('.', save_cursor) 
	endif
endfun
" }}}

" TeX_fmt() enters visual mode, which causes relative line numbers to be " shown...
nmap Q :call TeX_fmt()<CR><Esc>:set nornu<CR>

"set wrap
"set linebreak
set fo+=t
set fo+=l
set fo+=n
set fo+=w
set tw=80

" custom TeX text object for inline math
vnoremap am vF$vf$
onoremap am :normal vam<CR>
vnoremap im vF$lvf$h
onoremap im :normal vim<CR>

" for documents with lots of inline verbatim
iab <silent> ++ \verb!!<Left><C-R>=Eatchar('\s')<CR>
