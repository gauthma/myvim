"""" Settings for filetype=tex, that do *not* depend on TeX-9 (those are done
"""" in after/ftplugin/tex.vim.
""""
"""" Defined maps:
"""" - nnoremap <Leader>kal :call KillallLaTeX()<CR>
"""" - command WaB write | call s:BuildOnWrite()
"""" - cnoremap ww WaB

" settings for Tex-9. Add the below line to the config
" to enable debug output.
" \'debug' : 1,
let g:tex_nine_config = {
			\'leader': ':',
			\'compiler': 'make',
			\'viewer': {'app':'okular --unique', 'target':'pdf'},
		\}

" Custom TeX text object for inline math.
vnoremap am vmq?\$<cr>v/\$<cr>
onoremap am :normal vam<CR>`q
vnoremap im vmq?\$<cr>lv/\$<cr>h
onoremap im :normal vim<CR>`q

" syntax stuff (also see: after/syntax/tex.vim)
command! SyncFull  syntax sync fromstart
command! Sync      syntax sync minlines=500 match LaTeXSection       grouphere texSectionZone       "^\s*\\section{[a-zA-Z0-9]\+"

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
	" Then, append *relative* path of main TeX file, which if exists, is where
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

function! SyncTexForward()
	" TODO for a rainy day: figure out why the below line -- which needs no
	" redraw -- does NOT WORK: pdf just stays in the same place...
	" call system("okular --unique ".tex_nine#GetOutputFile()."\\#src:".line(".")."%:p &> /dev/null &")

	let cmd = "silent !okular --unique ".tex_nine#GetOutputFile()."\\#src:".line(".")."%:p &> /dev/null &"
	exec cmd
	redraw!
	redrawstatus!
endfunction
nmap <Leader>f :call SyncTexForward()<CR>
