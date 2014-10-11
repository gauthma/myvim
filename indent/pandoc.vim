" Vim indent file
" Language:     Markdown
" Maintainer:   Óscar Pereira <oscar@erroneousthoughts.org>
" Created:
" Last Change:
" Last Update:
" Version: 0.0.1

" Disable system wide indentation
let b:did_indent = 1 

if exists("b:did_pandoc_indent") | finish
endif
let b:did_pandoc_indent = 1

setlocal indentexpr=PandocIndent()
setlocal nolisp
setlocal nosmartindent
setlocal autoindent
" Vim has strict rules about this; for example, does NOT work with "* "
" setlocal indentkeys+==+<space>,

" Only define the function once
if exists("*PandocIndent") | finish
endif

function PandocIndent()
	" Find a non-blank line above the current line.
	let lnum = prevnonblank(v:lnum - 1)

	" At the start of the file use zero indent.
	if lnum == 0 | return 0 
	endif

	" matches bullets *, +. -, 1., 1)
	let bulletpat = '^\s*\(\(\-\|\*\|+\)\{1} \)\|\(\d\+\(\.\|)\)\{1}\) '
	let footnotepat = '^\[\^\d\+\]: '

	let cur_ind = indent(v:lnum - 1)     " indentation of previous line
	let pline  = getline(v:lnum - 1)     " previous line
	let cline = getline(v:lnum)          " current line
	
	let j = 0 " (1)
	let aux = ""
	while j < &shiftwidth
		let aux = aux . " "
		let j +=1
	endwhile

	" do not indent lines that begin bullets
	if cline =~ bulletpat
		return cur_ind
	endif

	if pline =~ bulletpat &&
				\ ( cur_ind > 0 || (getline(v:lnum - 2) =~ '^\s*$' ||
		                      \ indent (v:lnum - 2) > 0 ||
		                      \ getline(v:lnum - 2) =~ bulletpat)) " (3)
		let pline = substitute(pline, "\t", aux, "g") " (2)
		let idx = matchend(pline, bulletpat)

		if cline !~ bulletpat
			return idx
		else
			return indent(cline)
		endif
	endif

	if pline =~ footnotepat && 
				\ ( getline(v:lnum -2) =~ '^\s*$') " (5)
		return &sw + &sw
	endif

	return cur_ind " (4) by default return the indent of the previous line
endfunction

" DOCUMENTATION
"
" Rationale: 
"
" BULLET LISTS
"
" Consider the	following code snippet (the 11 is at start of line):
" 11. fo sdf sdf sdf sdf sdf sdf sdf sdf sdf sdf sdf sdf sdf sdf sdf
"     sdf sdf sdf sdf sdf
"     22. foof sdf sdf sdf sadf asdf saf sdf sdf sf sdf sadf sdf sdf
"         sdf sdf sdf sdf sdf sdf sdf asdf 
"
" To indent a bullet list, we check if we're on the first line of the bullet
" (which contains the 1. or 2. or ...). If so, do not touch indentation. If
" we're on the next line, then use matchend() to align with the start oftext
" of the previous line. However, matchend() does NOT handle tabs (it counts
" them as one char, which screws alignment), so we must calculate the needed
" amount of space for each tab (1), and then replace tabs for spaces before
" calculating the amount of indent space to return (2). On the next lines of a
" bullet just return the indent of the previous line.
"
" The if condition (3) is to detect if we're on the second line of a bullet:
" the previous line must match bulletpat and either 1) it has non-zero
" indentation (meaning it is a nested bullet) or the line previous to *that
" previous line* is either a) blank b) has non-zero indent (i.e. is the last
" of a previous bullet) or c) is a bullet.
"
" FOOTNOTES
"
" Consider the snippet (zero indent on first line):
"
" [^1]: sdf sdf sdf sdf sdf sdf sdf sdf sdf sdf sdf sdf sdf sdf sdf sdf sdf
" sdf sdf
"
" Markdown requires that all lines after first on footnote are indented with
" four spaces. So we use a similar rational (5) for the second line of a
" footnote. After that, like in the bullet case, the default applies.
"
" DEFAULT
"
" To indent other lines we return the indentation of the previous line (4).
