"""" Settings for filetype=tex, that do *not* depend on TeX-9 (those are done
"""" in after/ftplugin/tex.vim.
""""
"""" Defined maps:
"""" - nnoremap <Leader>kal :call KillallLaTeX()<CR>
"""" - command WaB write | call s:BuildOnWrite()
"""" - cnoremap ww WaB
"""" - nnoremap <Leader>Q mq:call FormatTeXparagraphs()<CR>`q

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

" Custom TeX text object for inline math.
vnoremap am vmq?\$<cr>v/\$<cr>
onoremap am :normal vam<CR>`q
vnoremap im vmq?\$<cr>lv/\$<cr>h
onoremap im :normal vim<CR>`q

" Run `make all` on background.
" Obviously, ignore include files...
" NOTA BENE: if a main TeX file exists, the Makefile is expected to exist in
" the same directory.
"
function! s:BuildOnWrite()
	" Check pre-conditions to build file
	let l:tex_build_pid = system("make --silent get_compiler_pid") " TODO handle case of more than 1 pid returned
	let l:filename = expand("%:p:t")
	if l:filename =~ '^inc_'
		return
	endif
	if l:tex_build_pid != ""
		echoerr "LaTeX compilation already running! Not interrupting... (" . l:tex_build_pid . ")"
		return
	endif

	" Get path of main TeX file, if it exists.
	" To do so, check if exists "mainfile" modline, like so:
	" % mainfile: ../thesis.tex
	let l:mainfile = ""
	let l:head = getline(1, 3)
	for line in l:head
		if line =~ '^%\s\+mainfile:\s\+\(\S\+\.tex\)'
			let l:mainfile = matchstr(line, '\(\S\+\.tex\)')
			break
		endif
	endfor

	" Initially, set path of Makefile to path of current file
	let l:makefile_path = expand("%:p:h")
	" Then, append relative path of main TeX file, which if exists, is where
	" Makefile must be
	if mainfile !~ '^$' 
		let l:makefile_path .= "/" . fnamemodify(l:mainfile, ":h") 
	endif

	" cd to dir that has Makefile, run make, and cd back
	if !filereadable(l:makefile_path . "/Makefile") | return | endif
	execute 'lcd' fnameescape(l:makefile_path)
	call system("make all &")
	lcd -
endfunction

function! KillallLaTeX()
	let l:tex_build_pid = system("make --silent get_compiler_pid") " TODO handle case of more than 1 pid returned
	call system("kill -TERM " . l:tex_build_pid)
endfunction

nnoremap <Leader>kal :call KillallLaTeX()<CR>
command! WaB write | call s:BuildOnWrite()
cnoremap ww WaB

" Visually selects a "TeX paragraph", and indents it (gqgq).
"
" A TeX paragraph are lines of text enclosed by either blank lines, or lines
" with just the comment symbol (%) -- plus a few special cases.
"
function! FormatTeXparagraphs()
	let l:linenum = line(".")
	let l:top = l:linenum
	let l:bottom = l:linenum

	" While loop to get the line num where the current paragraph starts...
	while l:top > 0
		let currentLine = getline(l:top - 1)
		" ... which is delimited by either a blank (or comment only) line, 
		" or \begin, \label, etc. Note that it is unlikely that the function
		" will be called when the cursor is actually ON one of these lines --> so
		" no need to make the function work on those cases.
		if currentLine =~ '^\s*$\|^\s*%\+\s*$' ||
					\ currentLine =~ '^\s*\\\(begin\|label\|\(sub\)\{0,2}section\|chapter\){.\+}.*$'
			" If if-cond matches, paragraph begins at current value of l:top, so exit loop
			break
		endif
		let l:top -=1
	endwhile

	" While loop to get the line num where the current paragraph ends...
	while l:bottom < line('$')
		let currentLine = getline(l:bottom + 1)
		" ... which is delimited by either a blank (or comment only) line, or
		" and \end command. Note that it is unlikely that the function will be
		" called when the cursor is actually ON one of these lines --> so " no
		" need to make the function work on those cases.
		if currentLine =~ '^\s*$\|^\s*%\+\s*$' ||
					\ currentLine =~ '^\s*\\end{.\+}\s*$'
			" If if-cond matches, paragraph ends at current value of l:bottom, so exit loop
			break
		endif
		let l:bottom +=1
	endwhile

	" Now that we now the numbers of the lines where the paragraph starts and
	" ends, go the start line, visually select until the end line, join them
	" into one line, and then format (gqgq) the whole mess. Profit!
	execute "normal! ".l:top."GV".l:bottom."GJgqgq"
endfunction

nnoremap <Leader>Q mq:call FormatTeXparagraphs()<CR>`q
