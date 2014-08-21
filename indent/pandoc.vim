" Vim indent file
" Language:     Pandoc
" Maintainer:   Óscar Pereira <oscar@erroneousthoughts.org>
" Created:
" Last Change:
" Last Update:
" Version: 0.0.1

" Disable system wide indentation
let b:did_indent = 1 

" Control TeX-9 indentation
if exists("b:did_pandoc_indent") | finish
endif
let b:did_pandoc_indent = 1

setlocal indentexpr=PandocIndent()
setlocal nolisp
setlocal nosmartindent
setlocal autoindent
" setlocal indentkeys+=},=\\item,=\\bibitem " check this XXX

" Only define the function once
if exists("*PandocIndent") | finish
endif

function PandocIndent()
	" Find a non-blank line above the current line.
	let lnum = prevnonblank(v:lnum - 1)

	" At the start of the file use zero indent.
	if lnum == 0 | return 0 
	endif

	let bulletpat = '^\s*\d\+\. '

	let cur_ind = indent(v:lnum - 1)
	let cline = getline(v:lnum)          " current line
	
	let j = 0 " (1)
	let aux = ""
	while j < &shiftwidth
		let aux = aux . " "
		let j +=1
	endwhile

	let start_of_bullet = BeginOfCurrentListItem(bulletpat) 
	if start_of_bullet != -1
		let line = substitute(getline(start_of_bullet), "\t", aux, "g") " (2)

		let idx = matchend(line, bulletpat)
		echo "idx " idx
		if cline !~ bulletpat 
			return idx
		else
			return indent(cline)
		endif
	endif

	return cur_ind " (4) by default return the indent of the previous line
endfunction

" returns the line number of the line that BEGINS 
" the current item list
function BeginOfCurrentListItem(listpat)
	let i = v:lnum
	let lnum = prevnonblank(i-1)

	while i >= lnum
		let line = getline(i)
		if line =~ a:listpat
			if i == 0 || line =~ '^\s\+' " (3)
				return i
			else
				let line = getline(i-1)
				if line =~ '^\s*$'
					return i
				endif
			endif
		endif
		let i -= 1
	endwhile
	return -1
endfunction

" DOCUMENTATION
"
" Rationale: Consider the		following code snippet (the 11 is at start of line):
" 11. fo sdf sdf sdf sdf sdf sdf sdf sdf sdf sdf sdf sdf sdf sdf sdf
"     sdf sdf sdf sdf sdf
"     22. foof sdf sdf sdf sadf asdf saf sdf sdf sf sdf sadf sdf sdf
"         sdf sdf sdf sdf sdf sdf sdf asdf 
"
" To indent a bullet list, we first discover the line where the current bullet
" starts (ie where the number is). Then use matchend() to align subsequent
" lines in that bullet. However, matchend() does NOT handle tabs (it counts
" them as one char, which screws alignment), so we must calculate the needed
" amount of space for each tab (1), and then replace tabs for spaces before
" calculating the amount of indent space to return (2).
"
" The function BeginOfCurrentListItem() returns the line where the current
" bullet begins. It discovers this by scanning lines upwards, until it finds
" one that matches the pattern. Note that it is NOT enough to just match the
" pattern though, because that will (erroneously) treat text lines that begin
" with /pattern/ also as bullet items. So a line that matches the /pattern/ is
" a bullet if it is the 1st line in file, or if it has some indentation space
" (see example snippet), or otherwise if the line above it is blank (3).
"
" To indent other lines we return the indentation of the previous line (4).
