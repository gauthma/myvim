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

" custom TeX text object for inline math
vnoremap am vF$vf$
onoremap am :normal vam<CR>
vnoremap im vF$lvf$h
onoremap im :normal vim<CR>

" Build TeX output on write of TeX source.
autocmd BufWritePost *.tex call BuildOnWrite()
" but allow it to be disabled
let s:auto_compile_on_save = 1 " enabled by default
fun! Toggle_auto_compile_on_save()
	if (s:auto_compile_on_save == 0)
		let s:auto_compile_on_save = 1
		echo "Auto compile on save ENABLED!"
	elseif (s:auto_compile_on_save == 1)
		let s:auto_compile_on_save = 0
		echo "Auto compile on save DISABLED!"
	endif
endfun
nnoremap <Leader>acs :call Toggle_auto_compile_on_save()<CR>

" Run `make all` on background.
" Obviously, ignore include files...
function! BuildOnWrite()
	let filename = expand("%:p:t")
	if s:auto_compile_on_save == 0 || filename =~ '^inc_'
		return
	endif
	call system("make all &")
endfunction
