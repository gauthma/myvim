" for spell checking 
noremap <M-F5> :'<,'>call SpellCheck("en", GetAspellMode())<cr>
noremap <M-F6> :'<,'>call SpellCheck("pt", GetAspellMode())<cr>

function! GetAspellMode()
	let l:filetype=&filetype
	let l:mode="none"

	if l:filetype ==? "tex"
		let l:mode="tex"
	elseif l:filetype ==? "mail"
		let l:mode="email"
	endif
	
	return l:mode
endfunction

function! SpellCheck(lang, mode) range
	if visualmode() != 'V'
		echo "Wrong mode: selection must be linewise ('V')!"
		return
	endif

	" get selected text
	normal! gv"xy
	let l:text=@x

	" Create temporary file (it's placed in /tmp because in
	" some systems, including ArchLinux, that folder is mapped to RAM)
	let l:tmpname= system('echo $random `date` | md5sum | cut -d" " -f1 | tr -d "\n"')
	let l:tmpfile="/tmp/" . l:tmpname

	" Write the selected text to the temp file
	execute "redir > " . l:tmpfile
	echo l:text
	redir END

	" Run spell checking on the temp file
	silent !clear
	if a:lang ==? "pt"
		execute "! aspell --dont-backup check --mode=" . a:mode . " -l pt_PT --variety=preao " . l:tmpfile 
	elseif a:lang ==? "en"
		execute "! aspell --dont-backup check --mode=" . a:mode . " -l en_GB " . l:tmpfile 
	endif

	" Read the temp into an array (one line per array element)
	" and dump the first element (it's a newline introduced by 
	" the echo command when redirecting output)
	let l:f=readfile(l:tmpfile)
	call remove(l:f, 0)

	" Join the array and put contents on register.
	let res=join(l:f, "\n")
	let @x=res . "\n"

	" Select the previous selection (the one that 
	" was pasted to the temp file), delete it and 
	" put in its place the (spell checked) text 
	" read from the temp file.
	" The report thingy is to suppress output when
	" deleting and pasting in the original file; 
	" this way the user is not asked to Press Enter
	" one more time.
	let l:report = &report
	set report=9999
	normal! gvd
	normal! "xP
	let &report = l:report

	" Remove the tmp file.
	call delete(l:tmpfile)
endfunction

