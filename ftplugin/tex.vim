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
nmap Q mq:call TeX_fmt()<CR><Esc>:set nornu<CR>`q

" custom TeX text object for inline math
vnoremap am vmq?\$<cr>v/\$<cr>
onoremap am :normal vam<CR>`q
vnoremap im vmq?\$<cr>lv/\$<cr>h
onoremap im :normal vim<CR>`q

if !exists("g:auto_compile_on_save")
	let g:auto_compile_on_save = 1 " enabled by default, unless already set
endif

function! Toggle_auto_compile_on_save()
	if (g:auto_compile_on_save == 0)
		let g:auto_compile_on_save = 1
		echo "Auto compile on save (*globally*) ENABLED!"
	elseif (g:auto_compile_on_save == 1)
		let g:auto_compile_on_save = 0
		echo "Auto compile on save (*globally*) DISABLED!"
	endif
endfun

" Run `make all` on background.
" Obviously, ignore include files...
" NOTA BENE: this assumes that the current dir is the same where 
" the Makefile (and the main *.tex file) are.
function! s:BuildOnWrite()
	if !filereadable("Makefile") | return | endif
	let l:tex_build_pid = system("make --silent get_compiler_pid") " TODO handle case of more than 1 pid returned
	let filename = expand("%:p:t")
	if g:auto_compile_on_save == 0 || filename =~ '^inc_'
		return
	endif
	if l:tex_build_pid != ""
		echoerr "LaTeX compilation already running! Not interrupting... (" . l:tex_build_pid . ")"
		return
	endif
	call system("make all &")
endfunction

function! KillallLaTeX()
	let l:tex_build_pid = system("make --silent get_compiler_pid") " TODO handle case of more than 1 pid returned
	call system("kill -TERM " . l:tex_build_pid)
endfunction

" Build TeX output on write of TeX source...
augroup BOW
	autocmd!
	autocmd BufWritePost * call s:BuildOnWrite()
augroup END
"... but allow it to be disabled
nnoremap <Leader>acs :call Toggle_auto_compile_on_save()<CR>
nnoremap <Leader>klc :call KillallLaTeX()<CR>
